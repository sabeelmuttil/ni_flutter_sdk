import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget {
  final double total;
  final bool isSamsungPayAvailable;
  final String currency;
  final VoidCallback onClickPayByCard;
  final VoidCallback onClickSamsungPay;
  // final SavedCard? savedCard;
  // final List<SavedCard> savedCards;
  // final Function(SavedCard) onSelectCard;
  // final Function(SavedCard) onDeleteSavedCard;
  // final Function(SavedCard) onPaySavedCard;

  const HomeBottomBar({
    super.key,
    required this.total,
    required this.isSamsungPayAvailable,
    required this.currency,
    required this.onClickPayByCard,
    required this.onClickSamsungPay,
    // required this.savedCard,
    // required this.savedCards,
    // required this.onSelectCard,
    // required this.onDeleteSavedCard,
    // required this.onPaySavedCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.green[200],
      child: Column(
        children: [
          Text("Total: $currency $total"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onClickPayByCard,
                child: const Text("Pay by Card"),
              ),
              if (isSamsungPayAvailable)
                ElevatedButton(
                  onPressed: onClickSamsungPay,
                  child: const Text("Samsung Pay"),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
