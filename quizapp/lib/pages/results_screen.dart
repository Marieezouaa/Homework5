import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultsScreen({Key? key, required this.score, required this.total}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(198, 243, 205, 33),
            Color.fromARGB(255, 39, 176, 130)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Make Scaffold background transparent
        appBar: AppBar(
          title: const Text('Quiz Summary'),
          backgroundColor: Colors.transparent, // Ensure AppBar blends with gradient
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Score: $score/$total', style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Retake Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
