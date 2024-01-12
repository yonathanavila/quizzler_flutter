import 'question.dart';

import 'package:flutter/material.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        backgroundColor: Colors.black12,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  List<bool> answers = [false, true, true];

  List<Question> questionBank = [
    Question(q: 'You can lead a cow down stairs but not up stairs.', a: false),
    Question(
        q: 'Approximately one quarter of human bones are in the feet', a: true),
    Question(q: 'A slug\'s blood is green.', a: true),
  ];

  int currentOptionSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank[currentOptionSelected].questionText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: const BorderSide(color: Colors.green),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                bool correctAnswers =
                    questionBank[currentOptionSelected].questionAnswer;

                if (correctAnswers == true) {
                  print('Correct!');
                } else {
                  print('Incorrect!');
                }

                //The user picked false.
                setState(
                  () {
                    currentOptionSelected++;
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                bool correctAnswers =
                    questionBank[currentOptionSelected].questionAnswer;

                if (correctAnswers == true) {
                  print('Correct!');
                } else {
                  print('Incorrect!');
                }

                //The user picked false.
                setState(
                  () {
                    currentOptionSelected++;
                  },
                );
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
