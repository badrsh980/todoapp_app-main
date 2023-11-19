import 'package:flutter/material.dart';
import 'package:note_app/Screen/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 3, 255, 116)),
        useMaterial3: true,
      ),
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
