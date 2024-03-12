import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/screens/categories.dart';

class App extends StatefulWidget {
  
  const App( { super.key } );

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {

  final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color.fromARGB(255, 131, 57, 0),
      ),
      textTheme: GoogleFonts.arimaTextTheme(),
    );
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: theme,
      home: const CategoriesScreen(),
    );
  }
}