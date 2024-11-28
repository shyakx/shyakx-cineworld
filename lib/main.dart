import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(CineWorldApp());
}

class CineWorldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineWorld',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
