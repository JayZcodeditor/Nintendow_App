import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home'; // Define a route name for the page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Nintendo Game Store!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can add navigation logic here
                // For example, navigate to the game details page
                Navigator.pushNamed(context, '/game');
              },
              child: Text('Browse Games'),
            ),
          ],
        ),
      ),
    );
  }
}
