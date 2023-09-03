import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/games.dart';
import 'package:flutter/widgets.dart';

class InfoGamePage extends StatefulWidget {
  static const String routeName = '/game';
  const InfoGamePage({super.key});

  @override
  _InfoGamePageState createState() => _InfoGamePageState();
}

class _InfoGamePageState extends State<InfoGamePage> {
  @override
  Widget build(BuildContext context) {
    final game = ModalRoute.of(context)!.settings.arguments as Games;

    var imgUrl = game.picture;
    imgUrl ??= "";
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Details'),
      ),
      body: Container(
        color: Colors.grey, // Set the background color here
        child: Center(
          child: Card(
            elevation: 4, // You can adjust the elevation as needed.
            margin: EdgeInsets.all(16), // You can adjust the margin as needed.
            child: Padding(
              padding: const EdgeInsets.all(
                  16.0), // You can adjust the padding as needed.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${game.title}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Image.network(
                    imgUrl,
                    width: 250,
                    height: 150,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${game.type}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${game.detail}',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '\$${game.price}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added to Cart')),
                      );
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
