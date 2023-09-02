import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/app_config.dart';
import 'package:flutter_application_1/models/users.dart';



class CartPage extends StatelessWidget {
  static const String routeName = '/cart';

  final Users user;

  CartPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: user.cart.isEmpty
          ? Center(
              child: Text('Your cart is empty.'),
            )
          : ListView.builder(
              itemCount: user.cart.length,
              itemBuilder: (BuildContext context, int index) {
                Cart cartItem = user.cart[index];
                return ListTile(
                  leading: Image.network(cartItem.gamePicture ?? ''),
                  title: Text(cartItem.gameTitle ?? 'Unknown Title'),
                  subtitle: Text('Price: \$${cartItem.gamePrice ?? '0.00'}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Add logic here to remove the item from the cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Removed from Cart')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
