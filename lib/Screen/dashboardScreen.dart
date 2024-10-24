import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String name;
  final String email;
  const DashboardScreen({required this.name, required this.email});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome ${widget.name}", style: const TextStyle(fontSize: 30),),
            Text("Welcome ${widget.email}"),
          ],
        ),
      ),
    );
  }
}
