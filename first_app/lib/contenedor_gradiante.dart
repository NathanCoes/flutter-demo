import 'package:flutter/material.dart';
import 'package:first_app/roling_dice.dart';

class ContenedorGradiante extends StatelessWidget {
  const ContenedorGradiante( { super.key, required this.colors } );

  final List<Color> colors;

  @override
  Widget build(context){
    return 
      Container (
        decoration: 
          BoxDecoration (
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        child: const Center (
          child: RolingDice(),
        ),
      );
  }
}

// class ContenedorGradiante extends StatelessWidget {
//   ContenedorGradiante( this.colorA, this.colorB, {super.key});

//   final Color colorA, colorB;

//   @override
//   Widget build(context){
//     return 
//       Container (
//         decoration: 
//           BoxDecoration (
//             gradient: LinearGradient(
//               colors: [ 
//                 colorA, 
//                 colorB,
//                 ],
//               begin: Alignment.bottomRight,
//               end: Alignment.topLeft,
//             ),
//           ),
//         child: const Center (
//           child: TextStyled("Hola mundo! V 1.0.2"),
//         ),
//       );
//   }
// }