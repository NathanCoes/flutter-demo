import 'package:flutter/material.dart';
import 'package:second_app/questions_screen.dart';
import 'package:second_app/start_screen.dart';
import 'package:second_app/data/questions.dart';
import 'package:second_app/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz( { super.key } );

  @override
  State<Quiz> createState(){
    return _QuizScreen();
  }
}

class _QuizScreen extends State<Quiz> {

  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer){
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length){
      setState((){
        activeScreen = 'results-screen';
      });
    }
  }

  void onRestart (){
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  @override

  Widget build (context) {

    Widget screenWidget = StartScrean(switchScreen);
    
    if ( activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    }

    if (activeScreen == 'results-screen'){
      screenWidget = ResultScreen(chosenAnswers: selectedAnswers, onRestart: onRestart,);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 3, 145, 163),
                  Color.fromRGBO(25, 118, 210, 1),
                ],
              ),
          ),
          child: screenWidget,
        ),
      )
    );
  }
}