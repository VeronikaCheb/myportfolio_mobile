import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00674F),
          secondary: const Color(0xFF800000),
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}