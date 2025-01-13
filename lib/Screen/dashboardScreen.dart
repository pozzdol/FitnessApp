import 'dart:convert';
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
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : exercises.isEmpty
          ? const Center(
        child: Text(
          'No exercises found',
          style: TextStyle(fontSize: 18),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${widget.name}',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Exercise List',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return Card(
                    elevation: 4,
                    margin:
                    const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        exercise['name'] ?? 'Unknown Exercise',
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        exercise['description'] ??
                            'No description available',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
