import 'package:flutter/material.dart';
import 'dart:math';

class RolingDice extends StatefulWidget {
  const RolingDice({super.key});

  @override
  State<RolingDice> createState(){
    return _RolingDiceState();
  }
}

final randomizer = Random();

class _RolingDiceState extends State<RolingDice> {

  var randomNum = randomizer.nextInt(6)+1;

  void rollDice(){
    setState( () {
      randomNum = randomizer.nextInt(6)+1;
    });
  }

  @override
  Widget build(context){
    return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/dice-images/dice-$randomNum.png',
                width: 200,
              ),
              // const SizedBox(height: 20),
              TextButton(
                onPressed: rollDice,
                style: TextButton.styleFrom(
                  // padding: const EdgeInsets.only(top: 20),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 28
                  ),
                ),
                child: const Text('Roll Dice')
              )
            ],
          );
  }
}