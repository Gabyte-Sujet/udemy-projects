import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.resultScore,
    required this.resetHandler,
  }) : super(key: key);

  final int resultScore;
  final VoidCallback resetHandler;

  String get resultPhrase {
    String resultText;
    if (resultScore <= 10) {
      resultText = 'A';
    } else if (resultScore <= 20) {
      resultText = 'B';
    } else {
      resultText = 'C';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Result is: $resultPhrase, score is: $resultScore',
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: resetHandler, child: const Text('Reset Quiz!'))
        ],
      ),
    );
  }
}
