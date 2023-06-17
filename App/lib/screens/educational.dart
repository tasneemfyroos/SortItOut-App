import 'package:flutter/material.dart';

import '../main.dart';


class WasteSortingQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
      fontFamily: 'marcellus',
    );
    return MaterialApp(
      // title: 'Waste Sorting Quiz',
      theme: ThemeData(
        primarySwatch: getColor(),
        textTheme: textTheme,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  bool isCorrect = false;

  List<Question> questions = [
    Question(
      'Which bin should you use for disposing of plastic bottles?',
      ['Green bin', 'Blue bin', 'Black bin'],
      1,
    ),
    Question(
      'What should you do with used batteries?',
      ['Recycle them', 'Throw them in the trash', 'Compost them'],
      0,
    ),
    Question(
      'Which bin should you use for paper and cardboard?',
      ['Green bin', 'Blue bin', 'Black bin'],
      1,
    ),
  ];

  void checkAnswer(int selectedIndex) {
    if (!isAnswered) {
      bool correct = selectedIndex == questions[currentQuestionIndex].correctAnswerIndex;
      if (correct) {
        score++;
      }

      setState(() {
        isAnswered = true;
        isCorrect = correct;
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isAnswered = false;
          isCorrect = false;
          if (currentQuestionIndex < questions.length - 1) {
            currentQuestionIndex++;
          } else {
            showResultDialog();
          }
        });
      });
    }
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Complete'),
          content: Text('Your score: $score/${questions.length}'),
          actions: [
            TextButton(
              child: Text('Restart'),
              onPressed: () {
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Waste Sorting Quiz',
                style: TextStyle(
                  fontFamily: "marcellus",
                  fontSize: 18,
                )),
            SizedBox(width: 8),
            Image(
                image: AssetImage('images/logo.png'),
                height:50),
          ],
        ),
        // title: Text('Waste Sorting Quiz'),

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              questions[currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Column(
              children: [
                for (int i = 0; i < questions[currentQuestionIndex].choices.length; i++)
                  ListTile(
                    title: Text(questions[currentQuestionIndex].choices[i]),
                    onTap: () => checkAnswer(i),
                    tileColor: isAnswered && i == questions[currentQuestionIndex].correctAnswerIndex
                        ? getColor()[700]
                        : isAnswered && i != questions[currentQuestionIndex].correctAnswerIndex
                            ? getColor()[600]
                            : null,
                  ),
              ],
            ),
            SizedBox(height: 16.0),
            Visibility(
              visible: isAnswered,
              child: Text(
                isCorrect ? 'Correct!' : 'Wrong!',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> choices;
  final int correctAnswerIndex;

  Question(this.questionText, this.choices, this.correctAnswerIndex);
}
