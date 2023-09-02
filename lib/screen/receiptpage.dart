import 'package:flutter/material.dart';

class ReceiptPage extends StatelessWidget {
  final List<Map<String, dynamic>> purchasedItems; // List of purchased items
  final double total; // Total amount spent

  ReceiptPage({required this.purchasedItems, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thank you for your purchase!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Transaction Date: ${DateTime.now().toString()}'),
            SizedBox(height: 20),
            Text('Purchased Items:'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: purchasedItems.length,
              itemBuilder: (context, index) {
                final item = purchasedItems[index];
                return ListTile(
                  title: Text(item['Game_title']),
                  subtitle: Text('Price: \$${item['Game_price']}'),
                  trailing: Text('Quantity: ${item['total']}'),
                );
              },
            ),
            SizedBox(height: 20),
            Text('Total Amount Spent: \$${total.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
