import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> games; // You should populate this list with game data

  HomePage({required this.games});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nintendo Game Store'),
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return ListTile(
            title: Text(game['title']),
            subtitle: Text('Type: ${game['type']}'),
            trailing: Text('\$${game['price']}'),
            onTap: () {
              // Navigate to the game details page (InfoGame) passing the game data
              Navigator.of(context).pushNamed('/infoGame', arguments: game);
            },
          );
        },
      ),
    );
  }
}
