import 'package:flutter/material.dart';

class InfoGamePage extends StatelessWidget {
  final Map<String, dynamic> game; // Game data passed from the home page

  InfoGamePage({required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              game['picture'], // Provide the URL to the game's picture
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text('Type: ${game['type']}'),
            Text('Price: \$${game['price']}'),
            SizedBox(height: 20),
            Text('Description:'),
            Text(game['detail']),
          ],
        ),
      ),
    );
  }
}
