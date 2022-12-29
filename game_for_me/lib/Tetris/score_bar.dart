import 'package:flutter/material.dart';

class ScoreBar extends StatefulWidget {
  const ScoreBar({super.key});

  @override
  State<ScoreBar> createState() => _ScoreBarState();
}

class _ScoreBarState extends State<ScoreBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // màu lan
        gradient: LinearGradient(
          colors: [Colors.indigo.shade400, Colors.white60],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Score 0",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
