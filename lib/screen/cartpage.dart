import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems; // List of items in the shopping cart

  CartPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          return ListTile(
            leading: Image.network(
              cartItem['Game_picture'], // URL to the game's picture
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            title: Text(cartItem['Game_title']),
            subtitle: Text('Price: \$${cartItem['Game_price']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    // Implement logic to decrease item quantity in the cart
                  },
                ),
                Text(cartItem['total']),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Implement logic to increase item quantity in the cart
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${calculateTotal(cartItems)}', // Implement a function to calculate the total price
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement logic to proceed to checkout
                Navigator.of(context).pushNamed('/receipt');
              },
              child: Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
