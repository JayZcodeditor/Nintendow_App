import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'screen/login.dart';
import 'screen/homepage.dart';
import 'screen/infogamepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Login(),
    Home(),
    InfoGamePage(),
    //CartPage(),
    //ReceiptPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
      initialRoute: '/', // Specify the initial route
      home: Scaffold(
        body: _pages[_selectedIndex], // Show the selected page
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: 'Login',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: NetworkImage(
                    "https://logos-download.com/wp-content/uploads/2021/02/Nintendo_Switch_Logo.png"),
                height: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey, // Set the color here
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}