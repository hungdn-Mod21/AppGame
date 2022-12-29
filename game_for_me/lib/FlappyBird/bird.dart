import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  // final birdY;
  // final double birdWidth;  
  // final double birdHeight;

  // Bird({this.birdY, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
       
      height: 60, width: 60,
      child: Image.asset("assets/images/dove.png", fit: BoxFit.fill,),
    );
  }
}
