import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/app_config.dart';
import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/models/games.dart';
import 'package:flutter_application_1/screen/infogamepage.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const routeName = "/";
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget mainBody = Container();
  List<Games> _gamelist = [];

  Future<void> getGames() async {
    var url = Uri.http(AppConfig.server, "Game"); // Change the endpoint to "games"
    var resp = await http.get(url);
    setState(() {
      _gamelist = gamesFromJson(resp.body);
      mainBody = showGames(_gamelist);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: mainBody, // Add the mainBody widget here
    );
  }

  @override
  void initState() {
    super.initState();
    Users user = AppConfig.login;
    if (user.id != null) {
      getGames();
    }
  }

  Widget showGames(List<Games> _gamelist) {
    return ListView.builder(
      itemCount: _gamelist.length,
      itemBuilder: (context, index) {
        Games game = _gamelist[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Handle dismiss action if needed
          },
          background: Container(
            color: Colors.red,
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, color: Colors.white),
          ),
          child: Card(
            child: ListTile(
              title: Text("${game.title}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoGamePage(), // Pass the game object as a parameter
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
