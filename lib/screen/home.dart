import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/config.dart';
import 'login.dart';
import 'package:flutter_application_1/models/user.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const routeName = "/";
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget mainBody = Container();
  List<Users> _userList = [];

  Future<void> getUsers() async {
    var url = Uri.http(Configure.server, "users");
    var resp = await http.get(url);
    setState(() {
      _userList = usersFromJson(resp.body);
      mainBody = showUsers();
    });
    return;
  }

  Future<void> removeUser(user) async{
  var url = Uri.http(Configure.server, "users/${user.id}");
  var resp = await http.delete(url);
  print(resp.body);
  return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: SideMenu(),
      body: mainBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserForm(),
            ),
          );

          if (result == "refresh") {
            getUsers();
          }
        },
        child: const Icon(Icons.person_add_alt_1),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    Users user = Configure.login;
    if (user.id != null) {
      getUsers();
    }
  }

  Widget showUsers() {
    return ListView.builder(
      itemCount: _userList.length,
      itemBuilder: (context, index) {
        Users user = _userList[index];
        return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              removeUser(user);
            },
            background: Container(
              color: Colors.red,
              margin: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
                child: ListTile(
                  title: Text("${user.fullname}"),
                  subtitle: Text("${user.email}"),
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => UserForm(),
                      settings: RouteSettings(
                        arguments: user
                      )
                    )
                    );
                  },
                  trailing: IconButton(
                    onPressed: () async {
                      String result = await Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => UserForm(),
                          settings: RouteSettings(
                            arguments: user
                          )));
                      if(result == "refresh") {
                        getUsers();
                      }
                    },
                    icon: Icon(Icons.edit),
                  ),
                )
            ),
        );
      },
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accountName = "N/A";
    String accountEmail = "N/A";
    String accountUrl =
        "https://scontent-sin6-4.xx.fbcdn.net/v/t39.30808-6/350126965_1662802190835972_1628233951997352663_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHHncBxURc0y8EuGZ74rZUJXsaOfYn0_VBexo59ifT9UBDCnpGb685xlmDFGLgAtYJ0OscvyBOB3lFK7eCuYYlS&_nc_ohc=DV-Gh1XUzlEAX_p3MH9&_nc_ht=scontent-sin6-4.xx&oh=00_AfDUY1jW6blXbFqKMR7NNkZ04pS17w44pguzt0oDHqdUiQ&oe=64F179E8";
    Users user = Configure.login;
    if (user.id != null) {
      accountName = user.fullname!;
      accountEmail = user.email!;
    }
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(accountUrl),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, Home.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Login"),
            onTap: () {
              Navigator.pushNamed(context, Login.routeName);
            },
          )
        ],
      ),
    );
  }
}
