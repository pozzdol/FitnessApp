import 'dart:convert';
import 'package:fitness/Screen/DetailedCardScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  final String name;
  final String email;
  const DashboardScreen({required this.name, required this.email, Key? key})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> exercises = [];
  String baseUrl = 'http://10.0.2.2/fitness';
  bool isLoading = true; // Tambahkan indikator loading

  Future<void> _fetchExercises() async {
    try {
      final apiUrl = '$baseUrl/ex.php';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          exercises = jsonDecode(response.body);
          isLoading = false; // Set loading selesai
        });
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading selesai meski gagal
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching exercises: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: exercises.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Welcome, ${widget.name}'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Excercise List"),
                  Expanded(
                    child: ListView.builder(
                        itemCount: exercises.length,
                        itemBuilder: (context, index) {
                          final exercise = exercises[index];
                          final imageUrl = '$baseUrl/${exercise['image_url']}';
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailedCardscreen(
                                        imageUrl: imageUrl,
                                        name: exercise['name'],
                                        slogan: exercise['slogan'],
                                        second: int.parse(exercise['second']),
                                        username: widget.name,
                                        usermail: widget.email,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(imageUrl),
                                  ),
                                  title: Text(exercise['name']),
                                  subtitle: Text(exercise['slogan']),
                                  trailing: Text('${exercise['second']}s'),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ));
  }
}
