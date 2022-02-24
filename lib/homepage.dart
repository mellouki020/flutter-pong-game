import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game_flutter/bell.dart';
import 'package:pong_game_flutter/brick.dart';
import 'package:pong_game_flutter/coverscreen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  // player variables (bottom brick)
  double playerX = -0.2;
  double playerWidth = 0.4;

  // ball variables
  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;


  // game settings
  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      //update direction
      updateDirection();

      //move bell
      moveBall();

      //check if player is dead
      if (isPlayerDead()) {
        timer.cancel();
        resetGame();
      };
    });
  }
  void resetGame() {
    setState(() {
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
    });
  }

  bool isPlayerDead(){
    if (ballX >= 1){

    }
    return false;
  }

  void updateDirection(){
    setState(() {
      // update vertical direction
      if (ballY >= 0.9 && playerX >= ballX && playerX + playerWidth <= ballX ) {
        ballYDirection = direction.UP;
      }else if (ballY <= -0.9) {
        ballYDirection = direction.DOWN;
      }

      // update horizontal direction
      if (ballX >= 1) {
        ballYDirection = direction.LEFT;
      }else if (ballX <= -1) {
        ballYDirection = direction.RIGHT;
      }
    });
  }

  void moveBall() {
    setState(() {
        // vertical movement
      if (ballYDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.01;
      }

      //horizontal movement
      if (ballXDirection == direction.LEFT) {
        ballX -= 0.01;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += 0.01;
      }
    });

  }

  void moveLeft () {
      setState(() {
        playerX -= 0.1;
      });

  }

  void moveRight() {
    setState(() {
      playerX += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
             moveBall();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            moveRight();
    }
    },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
              child: Stack(
                children: [
                   //tap to play
                  CoverScreen(
                    gameHasStarted: gameHasStarted,
                  ),

                  // top brick
                  MyBrick(
                      x: 0,
                      y: -0.9,
                      brickWidth: playerWidth,
                  ),

                  // bottom brick
                  MyBrick(
                      x: playerX,
                      y: 0.9,
                      brickWidth: playerWidth,
                  ),
                  // ball
                  MyBell(
                    x: ballX,
                    y: ballY,
                  ),
                  Container(
                    alignment: Alignment(playerX, 0.9),
                    child: Container(
                      width: 2,
                      height: 20,
                      color: Colors.red,
                    ),
                  ),
                  //
                ],
              )
          ),
        )
    )
    );

  }
}
