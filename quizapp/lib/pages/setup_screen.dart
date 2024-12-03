import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/pages/quiz_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final List<int> questionNumbers = [5, 10, 15];
  final List<String> difficulties = ['easy', 'medium', 'hard'];
  final List<String> types = ['Multiple Choice', 'True or False'];

  int? _selectedQuestions = 10;
  String? _selectedDifficulty = 'medium';
  String? _selectedType = 'Multiple Choice';

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'BrainBuzz Trivia',
            style: GoogleFonts.concertOne(
              fontSize: 32,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage("assets/images/brain.png")),
              Text(
                'Number of Questions:',
                style: GoogleFonts.concertOne(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              DropdownButton<int>(
                value: _selectedQuestions,
                items: questionNumbers
                    .map((number) => DropdownMenuItem<int>(
                          value: number,
                          child: Text(
                            number.toString(),
                            style: GoogleFonts.concertOne(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedQuestions = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Difficulty Level:',
                style: GoogleFonts.concertOne(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              DropdownButton<String>(
                value: _selectedDifficulty,
                items: difficulties
                    .map((difficulty) => DropdownMenuItem<String>(
                          value: difficulty,
                          child: Text(
                            difficulty,
                            style: GoogleFonts.concertOne(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDifficulty = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Type:',
                style: GoogleFonts.concertOne(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              DropdownButton<String>(
                value: _selectedType,
                items: types
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: GoogleFonts.concertOne(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
              ),
              const SizedBox(height: 200),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        numQuestions: _selectedQuestions!,
                        difficulty: _selectedDifficulty!,
                        type: _selectedType == 'True or False'
                            ? 'boolean'
                            : 'multiple',
                      ),
                    ),
                  );
                },
                child: const Text('Start Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
