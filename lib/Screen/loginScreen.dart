import 'dart:convert';

import 'package:fitness/Screen/dashboardScreen.dart';
import 'package:fitness/Screen/registerScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';

  bool _passwordVisible = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> login(email, password) async {
    const url = "http://10.0.2.2/fitness/login.php";

    try {
      final response = await http.post(Uri.parse(url),body: {
        'email': email,
        'password': password,
      });

      final responseData = json.decode(response.body);

      if (responseData["success"]) {
        final String name = responseData["name"];
        final String email = responseData["email"];

        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(name:name, email:email)));
      } else {
        final String errorMessage = responseData["message"];
        Toast.show(errorMessage,
            duration: Toast.lengthShort, gravity: Toast.top);

      }

    } catch (e) {
      Toast.show("An error occurred, please try again later!",
          duration: Toast.lengthShort, gravity: Toast.top);
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: Colors.grey,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/logo.png',
                    height: 150,
                    width: 150,
                    color: Colors.grey,
                    colorBlendMode: BlendMode.multiply,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200]),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter an email";
                        } else if (!value.contains('@')) {
                          return "Please enter an valid email address";
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200]),
                    child: TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_passwordVisible,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a password";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 character length";
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                      login(_email, _password);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Registerscreen()),
                        );
                      },
                      child: const Text(
                        "Not registered? Register!",
                        style: TextStyle(fontSize: 25, color: Colors.black54),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
