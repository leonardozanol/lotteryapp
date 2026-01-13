import 'package:flutter/material.dart';
import 'package:lottery_app/views/MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resultados Loteria',
      home: MyHomePage(),
    );
  }
}
