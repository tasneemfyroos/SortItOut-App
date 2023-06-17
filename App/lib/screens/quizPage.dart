import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_app_testing/screens/educational.dart';
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
      'What is wishful recycling?',
      ['Putting items in the recycling bin that are definitely recyclable ',
        'Wanting to recycle but have not started yet',
        'Putting items in the recycling bin that you hope is recyclable but are not sure',
        'Wishing for better recycling practices in your community'],
      2,
    ),
    Question(
      'True or false: Your banana peels, egg shells and watermelon rinds can be turned into fertilizer through composting.',
      ['True', 'False'],
      0,
    ),
    Question(
      'What can I do with my shirt that no longer fits me?',
      [' Donate it', 'Throw it in the trash', 'Reuse is as a rag', 'All of the above'],
      3,
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
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100), // Adjust the radius as desired
                    ),
                    color: getColor()[100],
                    child:
                    ListTile(
                      title: Text(questions[currentQuestionIndex].choices[i]),
                      onTap: () => checkAnswer(i),
                      tileColor: isAnswered && i == questions[currentQuestionIndex].correctAnswerIndex
                          ? getColor()[700]
                          : isAnswered && i != questions[currentQuestionIndex].correctAnswerIndex
                          ? getColor()[600]
                          : null,
                    ),
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