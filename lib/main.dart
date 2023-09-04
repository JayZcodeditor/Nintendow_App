import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'screen/login.dart';
import 'screen/homepage.dart';
import 'screen/cartpage.dart';
// import 'screen/receiptpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  int? _userId; // Add a userId field

  void _login(int userId) {
    // Simulate a successful login and store the user's ID
    setState(() {
      _isLoggedIn = true;
      _userId = userId; // Store the user's ID
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nintendo Game Store',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: _isLoggedIn
          ? MainApp(
              userId: _userId, // Provide the userId here
              logoutCallback: () {
                // Callback to logout and reset the _isLoggedIn state
                setState(() {
                  _isLoggedIn = false;
                  _userId = null; // Reset the user's ID
                });
              },
            )
          : Login(callbackLogin: _login),
    );
  }
}

class MainApp extends StatefulWidget {
  final int? userId;
  final VoidCallback logoutCallback; // Callback to logout

  MainApp({required this.userId, required this.logoutCallback, Key? key})
      : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    // ReceiptPage(),
    CartPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
