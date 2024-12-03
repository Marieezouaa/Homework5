import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/pages/results_screen.dart';

class QuizScreen extends StatefulWidget {
  final int numQuestions;
  final String difficulty;
  final String type;

  const QuizScreen({
    Key? key,
    required this.numQuestions,
    required this.difficulty,
    required this.type,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<dynamic>> _quizQuestions;
  int _currentQuestionIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _quizQuestions = _fetchQuestions();
  }

  Future<List<dynamic>> _fetchQuestions() async {
    final url =
        'https://opentdb.com/api.php?amount=${widget.numQuestions}&difficulty=${widget.difficulty}&type=${widget.type}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void _answerQuestion(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex < widget.numQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
             ResultsScreen(score: _score, total: widget.numQuestions),
        ),
      );
    }
  }

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
        backgroundColor:
            Colors.transparent, // Make Scaffold background transparent
        appBar: AppBar(
          title: Text(
            'Quiz',
            style: GoogleFonts.concertOne(
              fontSize: 32,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor:
              Colors.transparent, // Ensure AppBar blends with gradient
          elevation: 0,
        ),
        body: FutureBuilder<List<dynamic>>(
          future: _quizQuestions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final questions = snapshot.data!;
              final question = questions[_currentQuestionIndex];
              final options = [
                ...question['incorrect_answers'],
                question['correct_answer']
              ];
              options.shuffle();

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1}/${widget.numQuestions}',
                      style: GoogleFonts.concertOne(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question['question'],
                      style: GoogleFonts.concertOne(
                          fontSize: 22, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 16),
                    ...options.map((option) => ElevatedButton(
                          onPressed: () {
                            _answerQuestion(
                                option == question['correct_answer']);
                          },
                          child: Text(option),
                        )),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No questions found.'));
            }
          },
        ),
      ),
    );
  }
}
