import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final bool isSelected;
  final String currency;
  final VoidCallback onClick;
  final VoidCallback onDeleteProduct;

  const ProductItem({
    super.key,
    required this.product,
    required this.isSelected,
    required this.currency,
    required this.onClick,
    required this.onDeleteProduct,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        color: isSelected ? Colors.green.shade100 : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: 180,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(product.name), // Replace with actual product details
                  SizedBox(height: 10),
                  Text(product.amount.toString()),
                  // IconButton(
                  //   icon: const Icon(Icons.delete),
                  //   onPressed: onDeleteProduct,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
