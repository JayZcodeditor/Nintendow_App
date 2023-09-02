import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'screen/login.dart';
import 'screen/homepage.dart';
import 'screen/infogamepage.dart';

//import 'screen/cartpage.dart';
//import 'screen/receiptpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Widget> _pages = [
    Login(),
    HomePage(),
    InfoGamePage(),
    //CartPage(),
    //ReceiptPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nintendo Game Store',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/', // Specify the initial route
      routes: {
        '/home': (context) => HomePage(), // Login page as the initial route
        '/login': (context) => Login(), // Define other routes here
        '/game': (context) => InfoGamePage(),
        //'/cart': (context) => CartPage(),
        //'/receipt': (context) => ReceiptPage(),
      },
      home: Scaffold(
        body: _pages[0], // Initially, show the Login page
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: 'Login',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gamepad),
              label: 'Game',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'Receipt',
            ),
          ],
          selectedItemColor: Colors.black,        
          unselectedItemColor: Colors.grey, // Set the color here
          onTap: (int index) {
            // Handle navigation when a bottom navigation item is tapped
            // Update the body to show the selected page
            // You can also add more logic here as needed
            Navigator.of(context).pushReplacementNamed(
              index == 0 ? '/' : '/home', // Use the defined routes
            );
          },
        ),
      ),
    );
  }
}

