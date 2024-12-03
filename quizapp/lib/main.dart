import 'package:flutter/material.dart';
import 'package:quizapp/pages/setup_screen.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainBuzz',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SetupScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
