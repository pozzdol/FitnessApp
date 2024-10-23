import 'package:flutter/material.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '', _email = '', _password = '';

  bool _passwordVisible = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("Register"),
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
                  // Name Field
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200]),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                      onSaved: (value) => _name = value.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Email Field
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200]),
                    child: TextFormField(
                      controller: emailController,
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
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Password Field
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200]),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
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
                          return "Password must be at least 6 characters long";
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Register Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // You can handle the registration logic here
                        print('Name: $_name, Email: $_email, Password: $_password');
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Back to Login Button
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already registered? Login!",
                      style: TextStyle(fontSize: 25, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}