import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/questions_summary.dart';

import 'data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {Key? key, required this.chosenAnswers, required this.restartQuiz})
      : super(key: key);

  final List<String> chosenAnswers;
  final void Function() restartQuiz;

  // List<Map<String, Object>> getSummaryData() {
  //   List<Map<String, Object>> summary = [];

  //   for (var i = 0; i < chosenAnswers.length; i++) {
  //     summary.add(
  //       {
  //         'question_index': i,
  //         'question': questions[i].text,
  //         'correct_answer': questions[i].answers[0],
  //         'user_answer': chosenAnswers[i],
  //       },
  //     );
  //   }
  //   return summary;
  // }

  List<Map<String, Object>> get getSummaryData {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i],
        },
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    // final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = getSummaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            QuestionsSummary(summaryData: getSummaryData),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              label: const Text(
                'Restart Quiz!',
                style: TextStyle(fontSize: 18),
              ),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
