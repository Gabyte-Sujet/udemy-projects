import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class Quiz extends StatelessWidget {
  const Quiz({
    Key? key,
    required this.answerQuestion,
    required this.questionIndex,
    required this.questions,
  }) : super(key: key);

  final List<Map<String, Object>> questions;
  final Function answerQuestion;
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(questions[questionIndex]['questionText'] as String),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map(
              (answer) => Answer(
                () => answerQuestion(answer['score']),
                answer['text'] as String,
              ),
            )
            .toList(),
      ],
    );
  }
}
