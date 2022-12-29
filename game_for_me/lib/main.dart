import 'package:flutter/material.dart';
import 'package:game_for_me/FlappyBird/flappy_bird.dart';
import 'package:game_for_me/Tetris/tetris.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const FlappyBird(),
      home: const Tetris(),
    );
  }
}
