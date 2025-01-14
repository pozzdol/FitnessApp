import 'dart:async';

import 'package:flutter/material.dart';

class DetailedCardscreen extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String slogan;
  final int second;
  final String username;
  final String usermail;

  DetailedCardscreen({
    required this.imageUrl,
    required this.name,
    required this.slogan,
    required this.second,
    required this.username,
    required this.usermail,
  });

  @override
  State<DetailedCardscreen> createState() => _DetailedCardscreenState();
}

class _DetailedCardscreenState extends State<DetailedCardscreen> {
  late int _secondRemaining;
  late bool _isCounting;
  late bool _excerciseCompleted;

  @override
  void initState() {
    super.initState();
    _secondRemaining = widget.second;
    _isCounting = false;
    _excerciseCompleted = false;
  }

  void _startCounting() {
    setState(() {
      _isCounting = true;
    });

    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (_secondRemaining == 0) {
        setState(() {
          _isCounting = false;
          _excerciseCompleted = true;
        });
      } else {
        setState(() {
          _secondRemaining--;
        });
      }
    });
  }

  Future<void> _loadExcerciseComplicationState() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Excercise Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          Text('Welcome, ${widget.username}'),
          SizedBox(
            height: 10,
          ),
          Text('Welcome, ${widget.usermail}'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.network(widget.imageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.slogan,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 16,
                ),
                _isCounting
                    ? Column(
                        children: [
                          CircularProgressIndicator(
                            value: (_secondRemaining / widget.second),
                            strokeWidth: 10,
                            backgroundColor: Colors.grey,
                            valueColor:
                                const AlwaysStoppedAnimation(Colors.blue),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${_secondRemaining} seconds',
                            style: const TextStyle(fontSize: 24),
                          )
                        ],
                      )
                    : const SizedBox(
                        height: 16.0,
                      ),
                _excerciseCompleted
                    ? const Column(
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Excercise Complited',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _startCounting();
                        },
                        child: Text(_isCounting
                            ? 'Counting Down...'
                            : 'Start Counting'),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
