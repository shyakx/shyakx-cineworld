import 'package:flutter/material.dart';
import '/home_screen.dart';
import '/details_screen.dart';
import '/search_screen.dart';

void main() {
  runApp(CineWorldApp());
}

class CineWorldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineWorld',
      theme: ThemeData(
        primarySwatch: Colors.orange, // Change the theme color
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 171, 177, 40), // Dark AppBar for contrast
          iconTheme: IconThemeData(
            color: Colors.white, // AppBar icon color
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(movieId: 0), // Placeholder
        '/search': (context) => SearchScreen(),
      },
    );
  }
}