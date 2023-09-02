import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InfoGamePage extends StatelessWidget {
  static const String routeName = '/game'; // Define a route name for the page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://cdn.freebiesupply.com/logos/large/2x/nintendo-2-logo-png-transparent.png',
              width: 200, // Adjust the width as needed
            ),
            SizedBox(height: 20),
            Text(
              'The Legend of Zelda™: Tears of the Kingdom',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Adventure',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'An epic adventure awaits in the Legend of Zelda: Tears of the Kingdom game, only on the Nintendo Switch system. In this sequel to the Legend of Zelda: Breath of the Wild game, you’ll decide your own path through the sprawling landscapes of Hyrule and the mysterious islands floating in the vast skies above. Can you harness the power of Link’s new abilities to fight back against the malevolent forces that threaten the kingdom?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              '\$69.99',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can add logic here to add the game to the cart
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to Cart')),
                );
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}