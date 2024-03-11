import 'package:flutter/material.dart';
import 'package:first_app/contenedor_gradiante.dart';

void main() {
  runApp (
    const MaterialApp (
      home: Scaffold (
        body: ContenedorGradiante(
            colors: [
              Color.fromARGB(255, 36, 95, 134), 
              Color.fromARGB(255, 1, 147, 167)
            ]
          ),
      ),
    ),
  );
}

