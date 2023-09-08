import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/app_config.dart';
import 'package:flutter_application_1/models/users.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  static const routeName = "/login";
  final Function(int?)
      callbackLogin; // Change the callback type to accept an integer or null

  Login({required this.callbackLogin, Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formkey = GlobalKey<FormState>();
  Users user = Users();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.network(
        'https://cdn.freebiesupply.com/logos/large/2x/nintendo-2-logo-png-transparent.png',
        height: 120, // Adjust the height as needed
      )),
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
          return "It is not an email format";
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
          // Store the user's ID
          int userId = login_result[0].id ??
              0; // Replace 0 with a default value if id is null
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Success")),
          );
          // Call the callback function with the userId
          widget.callbackLogin(userId);
          print(userId);
          // Navigate to the home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainApp(
                userId: userId,
                logoutCallback: () {
                  // Handle logout callback
                },
              ),
            ),
          );
        }
      }
      ;
    } catch (e) {
      // Handle other errors, such as network errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout Success")),
      );
      print("Error during login: $e");
    }
  }
}
