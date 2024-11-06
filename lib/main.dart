import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizhub/home.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QuizHub",
      home: Builder(
        builder: (context) {
          // Use Builder to obtain the context
          Timer(const Duration(seconds: 3), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          });

          return const Scaffold(
            backgroundColor: Color.fromARGB(204, 244, 244, 4),
            body: Center(
              child: Text('QuizHub',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontFamily: 'DancingScript',
                  )),
            ),
          );
        },
      ),
    );
  }
}
