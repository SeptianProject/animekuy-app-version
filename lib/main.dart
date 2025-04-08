import 'package:animekuy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AnimeKuyApp());
}

class AnimeKuyApp extends StatelessWidget {
  const AnimeKuyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimeKuy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(ColorsConstants.primaryColor),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
