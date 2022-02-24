import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {

  final x;
  final y;
  final brickWidth;

  MyBrick({this.x, this.y, this.brickWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white,
            height: 20,
            width: MediaQuery.of(context).size.width / 5,
          ),
        )
    );
  }
}
