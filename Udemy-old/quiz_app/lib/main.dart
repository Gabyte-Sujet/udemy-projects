import 'package:flutter/material.dart';

import 'quiz.dart';
import 'result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Quiz App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, Object>> _questions = const [
    {
      "questionText": "What's your fav color?",
      "answers": [
        {"text": "Red", "score": 10},
        {"text": "Green", "score": 5},
        {"text": "Blue", "score": 3},
        {"text": "Yellow", "score": 1},
      ],
    },
    {
      "questionText": "What's your fav animal?",
      "answers": [
        {"text": "Dog", "score": 10},
        {"text": "Cat", "score": 5},
        {"text": "Elephant", "score": 3},
        {"text": "Lion", "score": 1},
      ],
    },
    {
      "questionText": "What's your fav number?",
      "answers": [
        {"text": "One", "score": 10},
        {"text": "Two", "score": 5},
        {"text": "Three", "score": 3},
        {"text": "Four", "score": 1},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    setState(() {
      _questionIndex += 1;
      _totalScore += score;
    });

    print(_questionIndex);

    if (_questionIndex < _questions.length) {
      print('We have more questions.');
    } else {
      print('No more questions.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : Result(resultScore: _totalScore, resetHandler: _resetQuiz),
    );
  }
}
