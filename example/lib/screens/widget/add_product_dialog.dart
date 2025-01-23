import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../../utils/app_enum.dart';

AlertMessage getAlertMessage(MainViewModelStateType state, String message) {
  // Implement your alert message logic here
  return AlertMessage(title: "Title", message: message);
}

class AlertMessage {
  final String title;
  final String message;

  AlertMessage({required this.title, required this.message});
}

class AddProductDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final Function(ProductModel) onAddProduct;

  const AddProductDialog({
    super.key,
    required this.onCancel,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Product"),
      content: const Text("Product details form goes here."),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // Replace with actual product creation logic
            onAddProduct(
              ProductModel(
                name: "Product Name",
                amount: 1.0,
              ),
            );
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
