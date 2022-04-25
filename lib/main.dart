import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'question.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: QuizApp(),
        ),
      ),
    ));


class QuizApp extends StatefulWidget {


  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {

    if(quizBrain.questionNumber == 2) {
      Alert(
        context: context,
        title: "Finished!",
        desc: "You have reached the end of quiz..",
        buttons: [
          DialogButton(
            child: const Text(
              "RESTART",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () =>
            {
              quizBrain.questionNumber = 0,
              scoreKeeper = [],
              Navigator.pop(context),
            },
            width: 120,
          )
        ],
      ).show();
    }

    print('Quiz Length ${quizBrain.questionNumber}');

    if(userPickedAnswer == quizBrain.getCorrectAnswer()) {
      scoreKeeper.add(const Icon(Icons.done , color: Colors.green,));
      if (kDebugMode) {
        print('user got it right!');
      }
    } else {
      scoreKeeper.add(const Icon(Icons.close , color: Colors.red,));
      if (kDebugMode) {

        print('user got it wrong!');
      }
    }

    setState(() {
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:<Widget> [
         Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child:
              Text(
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
          flex: 2,
          child: Padding(
            padding:  const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                checkAnswer(true);
              },
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}


