import 'quiz_brain.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

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

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (userPickedAnswer == correctAnswer) {
        if (!quizBrain.isFinished(scoreKeeper.length)) {
          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          Alert(
            context: context,
            title: "Finished!",
            desc: "Awesome!, You finished the quiz.",
          ).show();
          quizBrain.resetQuizBrain();
          scoreKeeper.clear();
        }
      } else {
        if (!quizBrain.isFinished(scoreKeeper.length)) {
          scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        } else {
          Alert(
            context: context,
            title: "Finished!",
            desc: "Awesome!, You finished the quiz.",
          ).show();
          quizBrain.resetQuizBrain();
          scoreKeeper.clear();
        }
      }

      quizBrain.nextQuestion();
    });
  }

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
                quizBrain.getQuestionText(),
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
                checkAnswer(true);
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
                checkAnswer(false);
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
