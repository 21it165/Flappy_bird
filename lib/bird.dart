import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {

  // ignore: prefer_typing_uninitialized_variables
  final birdY;
  final double birdWidth;
  final double birdheight;
  
  // ignore: prefer_const_constructors_in_immutables
  MyBird({super.key, this.birdY, required this.birdWidth, required this.birdheight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdY + birdheight)/ (2-birdheight)),
     //color: Colors.black,
      child: Image.asset(
        'lib/images/bird.png',
        height: MediaQuery.of(context).size.height *3/4* birdheight /2,
        width: MediaQuery.of(context).size.width * birdWidth /2,
        fit: BoxFit.fill,
        )
    );
  }
}