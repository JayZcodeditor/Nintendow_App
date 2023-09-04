import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/users.dart';

class ReceiptPage extends StatelessWidget {
  static const String routeName = '/receipt';

  final Users user;

  ReceiptPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Order Date: ${DateTime.now().toLocal()}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Order Number: ${generateOrderNumber()}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Items:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: user.cart.length,
            //   itemBuilder: (context, index) {
            //     final cartItem = user.cart[index];
            //     return ListTile(
            //       title: Text(cartItem.gameTitle ?? 'Unknown Title'),
            //       subtitle: Text('Price: \$${cartItem.gamePrice ?? '0.00'}'),
            //     );
            //   },
            // ),
            // SizedBox(height: 16),
            // Text(
            //   'Total: \$${calculateTotal()}',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }

  String generateOrderNumber() {
    // Implement logic to generate a unique order number
    // You can use date and time, or any other method
    return 'ORD-${DateTime.now().millisecondsSinceEpoch}';
  }

  // double calculateTotal() {
  //   double total = 0.0;
  //   for (final cartItem in user.cart) {
  //     final price = double.tryParse(cartItem.gamePrice ?? '0.00') ?? 0.0;
  //     total += price;
  //   }
  //   return total;
  // }
}
