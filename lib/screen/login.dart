import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_application_1/models/app_config.dart';
import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/screen/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  Users user = Users();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://cdn.freebiesupply.com/logos/large/2x/nintendo-2-logo-png-transparent.png',
          height: 120, // Adjust the height as needed
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              textHeader(),
              SizedBox(
                height: 15.0,
              ),
              emailInputField(),
              passwordInputField(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  submitButton(),
                  SizedBox(
                    width: 10.0,
                  ),
                  // backButton(),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textHeader() {
    return Center(
      child: Text(
        "Nintendo Account",
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: "test@gmail.com",
      decoration: InputDecoration(labelText: "Email:", icon: Icon(Icons.email)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        if (!EmailValidator.validate(value)) {
          return "It is not email format";
        }
        return null;
      },
      onSaved: (newValue) => user.email = newValue,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: "1q2w3e4r",
      obscureText: true,
      decoration:
          InputDecoration(labelText: "Password:", icon: Icon(Icons.lock)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue,
    );
  }

  Widget submitButton() {
    return Center(
      child: SizedBox(
        width: 200.0,
        child: ElevatedButton(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              _formkey.currentState!.save();
              print(user.toJson().toString());
              login(user);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Set the border radius
            ),
          ),
          child: Text("Sign in"),
        ),
      ),
    );
  }

  Widget backButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context); // Navigate back to the previous screen
      },
      child: Text("Back"),
    );
  }

  Future<void> login(Users user) async {
    try {
      var params = {"email": user.email, "password": user.password};
      var url = Uri.http(AppConfig.server, "users", params);
      var resp = await http.get(url);

      if (resp.statusCode == 200) {
        List<Users> login_result = usersFromJson(resp.body);

        if (login_result.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Username or password invalid")),
          );
        } else {
          AppConfig.login = login_result[0];
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      } else {
        print("Failed to load data from the server");
      }
    } catch (e) {
      print("Error during login: $e");
    }
  }
}
