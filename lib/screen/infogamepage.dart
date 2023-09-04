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
        title: Image.network(
          'https://cdn.freebiesupply.com/logos/large/2x/nintendo-2-logo-png-transparent.png',
          height: 120, // Adjust the height as needed
        ),
      ),
      body: Container(
        color: Colors.grey, // Set the background color here
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 4, // You can adjust the elevation as needed.
              margin: EdgeInsets.all(8), // You can adjust the margin as needed.
              child: Padding(
                padding: const EdgeInsets.all(
                    16.0), // You can adjust the padding as needed.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Align all elements to the left
                  children: <Widget>[
                    Text(
                      '${game.title}',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: 10), // Add some space between title and image
                    Image.network(
                      imgUrl,
                      height: 260, // Set the fixed height
                    ),
                    SizedBox(
                        height: 20), // Add some space between image and type
                    Text(
                      '${game.type}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                        height: 20), // Add some space between type and detail
                    Text(
                      '${game.detail}',
                    ),
                    SizedBox(
                        height: 20), // Add some space between detail and price
                    Text(
                      '\$${game.price}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: 10), // Add some space between price and buttons
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Align buttons to the left
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added to Cart')),
                            );
                          },
                          child: Text('Add to Cart'),
                        ),
                        SizedBox(width: 10), // Add some space between buttons
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Buy Now')),
                            );
                            // Add any additional logic for the "Buy Now" action here
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          child: Text('Buy Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
