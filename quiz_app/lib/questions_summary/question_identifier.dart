
import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget{
  const QuestionIdentifier({
    super.key,
    required this.isCorrect,
    required this.questionIndex
  });

  final int questionIndex;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final questionNumber = questionIndex + 1;

    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isCorrect 
          ? const Color.fromARGB(255, 153, 241, 150)
          : const Color.fromARGB(255, 249, 133, 133),
        borderRadius: BorderRadius.circular(100)
      ),
      child: Text(
        questionNumber.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 2, 36, 56),
        ),
      ),
    );
  }
}