import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  const Question(this.questionText, {Key? key}) : super(key: key);

  final String questionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        questionText,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 28),
      ),
    );
  }
}
