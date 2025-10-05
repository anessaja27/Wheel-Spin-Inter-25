import 'package:flutter/material.dart';
import 'screen/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wheel Spin Inter'25",
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF004030),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF123524),
          titleTextStyle: TextStyle(color: Color(0xFF5D866C), fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      home: const HomePage(),
    );
  }
}
