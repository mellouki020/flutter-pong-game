import 'package:flutter/material.dart';

class MyBell extends StatelessWidget {
  final x;
  final y;

  MyBell({this.x,this.y});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x,y),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        width: 20,
        height: 20,
      ),
    );
  }
}
