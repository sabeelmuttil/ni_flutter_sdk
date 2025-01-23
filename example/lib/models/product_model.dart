import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ProductModel {
  final String id;
  final String name;
  final double amount;
  final bool isLocal;

  ProductModel({
    String? id,
    required this.name,
    required this.amount,
    this.isLocal = false,
  }) : id = id ?? const Uuid().v4();

  // Convert a Product to a Map (for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'isLocal': isLocal,
    };
  }

  // Create a Product from a Map (for JSON deserialization)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      isLocal: json['isLocal'] ?? false,
    );
  }

  // Save a list of products to SharedPreferences
  static Future<void> saveProducts(List<ProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final json =
        jsonEncode(products.map((product) => product.toJson()).toList());
    await prefs.setString('products', json);
  }

  // Retrieve a list of products from SharedPreferences
  static Future<List<ProductModel>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('products');
    if (json != null) {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
