import 'dart:async';
// import 'dart:ffi';

import 'package:game_for_me/FlappyBird/barriers.dart';
import 'package:game_for_me/FlappyBird/bird.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FlappyBird extends StatefulWidget {
  const FlappyBird({super.key});

  @override
  State<FlappyBird> createState() => _FlappyBirdState();
}

class _FlappyBirdState extends State<FlappyBird> {
  // toạ độ vị trí Y Bird
  static double indexBirdY = 0; // biến tĩnh
  // thời gian
  double time = 0;
  // chiều cao
  double height = 0;
  // chiều cao ban đầu
  double initialHeight =
      indexBirdY; // chiều cao ban đầu bằng toạ độ y = 0 , toạ độ đang vị trí 0,0
  // kiểm tra bắt đầu chơi
  bool gameHasStarted = false; // gameHasStarted(trò chơi đã bắt đầu)
  // vị trí toạ độ X cột chắn
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5; // khoảng cách cho các cột
  // điểm
  int score = 0;

  // function nhảy
  void jump() {
    setState(() {
      time = 0;
      initialHeight = indexBirdY;
    });
  }

  MyBarrier brAbove = new MyBarrier(isThisBottomBarrier: false);
  MyBarrier brBelow = new MyBarrier(isThisBottomBarrier: true);

  // Dào cản
  static List<double> barrierX = [0.5, 0.5 + 1.5];
  static double barrierWidth = 0.5; // trong số 2
  List<List<double>> barrierHeight = [
    // trong số 2 , trong đó 2 là toàn bộ chiều cao của màn hình
    // [topHeight, bottomHeight]
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  // function bắt đầu chơi
  void startPlay() {
    gameHasStarted = true;
    // Timer(Hẹn giờ) , periodic(định kỳ) , Duration(khoảng thời gian) , milliseconds(thời gian thực hiện 1 chu kỳ)
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      // cộng thời gian
      time += 0.05;
      // chiều cao nhảy lên
      height = -4.9 * time * time +
          2.3 *
              time; // bắt đầu tính từ vị trí 0,0 ( gravity * time * time + velocity * time )

      setState(() {
        indexBirdY = initialHeight - height; // toạ đọ khi rơi xuống
      });

      // Di chuyển cột ,đặt vị trí toạ độ X cột chắn, khoảng cách các cột
      // setState(() {
      //   if (barrierXone < -1.5) {
      //     barrierXone += 3;
      //   } else {
      //     barrierXone -= 0.05;
      //   }
      // });

      // setState(() {
      //   if (barrierXtwo < -1.5) {
      //     barrierXtwo += 3;
      //   } else {
      //     barrierXtwo -= 0.05;
      //   }
      // });

      setState(() {
        for (int i = 0; i < barrierX.length; i++) {
          if (barrierX[0] < -1.5) {
            barrierX[0] += 3;
          } else {
            barrierX[0] -= 0.05;
          }
        }
      });

      setState(() {
        for (int i = 0; i < barrierX.length; i++) {
          if (barrierX[1] < -1.5) {
            barrierX[1] += 3;
          } else {
            barrierX[1] -= 0.05;
          }
        }
      });

      // điểm
      setState(() {
        // if (barrierXone < -1.5 || barrierXtwo < -1.5) {
        //   score += 1;
        // }
        for (int i = 0; i < barrierX.length; i++) {
          if (barrierX[i] < -0.2 && barrierX[i] > -0.3) {
            score += 1;
          }
        }
      });

      if (birdIsDead() == true) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }
    });
  }

  // function Chim chết
  bool birdIsDead() {
    if (indexBirdY > 1 || indexBirdY < -1) {
      return true;
    }

    // hits barriers
    // check if bird is within x coordinates and y coordinates of barriers
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= barrierWidth &&
          barrierX[i] + barrierWidth >= -barrierWidth &&
          (indexBirdY <= -1 + barrierHeight[i][0] ||
              indexBirdY + height >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }

    return false;
  }

  // Cài lại game
  void resetGame() {
    Navigator.pop(context);
    setState(() {
      indexBirdY = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = indexBirdY;
      barrierXone = 1;
      barrierXtwo = barrierXone + 1.5;
      barrierX = [0.5, 0.5 + 1.5];
      score = 0;
    });
  }

  // Hiện ra hộp thoại khi chết
  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff6CD0FF),
            title: Center(
              child: Text(
                " GAME OVER ",
                style: TextStyle(
                    color: Color(0xff970D1A),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              Text("SCORE : $score",
                  style: TextStyle(
                      color: Color(0xff0BAB64),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      "EXIT",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        if (gameHasStarted == true) {
          jump();
        } else {
          startPlay();
        }
      }),
      child: Scaffold(
        body: Column(
          children: [
            // ------------------------------ Phần chính --------------------------------
            Expanded(
              flex: 4, // chia phần
              child: Stack(
                children: [
                  // --- ảnh bird
                  AnimatedContainer(
                    alignment: Alignment(0, indexBirdY),
                    // thời gian
                    duration: Duration(milliseconds: 0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // ảnh nền
                        image: AssetImage("assets/images/backgr_bird.webp"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Bird(),
                  ),
                  // --- ảnh ngón tay
                  Container(
                    // đặt vị trí
                    alignment: Alignment(0, 0.3),
                    child: gameHasStarted
                        ? Text("")
                        : Container(
                            height: 80,
                            width: 80,
                            child: Image.asset(
                              "assets/images/tap.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                  // --- Các Rào cản

                  // AnimatedContainer(
                  //   alignment: Alignment(barrierXone, 1.1),
                  //   duration: Duration(milliseconds: 0),
                  //   child: MyBarrier(size: 200.0),
                  // ),
                  // AnimatedContainer(
                  //   alignment: Alignment(barrierXone, -1.1),
                  //   duration: Duration(milliseconds: 0),
                  //   child: MyBarrier(size: 200.0),
                  // ),
                  // AnimatedContainer(
                  //   alignment: Alignment(barrierXtwo, -1.1),
                  //   duration: Duration(milliseconds: 0),
                  //   child: MyBarrier(size: 150.0),
                  // ),
                  // AnimatedContainer(
                  //   alignment: Alignment(barrierXtwo, 1.1),
                  //   duration: Duration(milliseconds: 0),
                  //   child: MyBarrier(size: 300.0),
                  // ),

                  // top barrier 0
                  MyBarrier(
                    barrierX: barrierX[0],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[0][0],
                    isThisBottomBarrier: false,
                  ),
                  // bottom barrier 0
                  MyBarrier(
                    barrierX: barrierX[0],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[0][1],
                    isThisBottomBarrier: true,
                  ),
                  // top barrier 1
                  MyBarrier(
                    barrierX: barrierX[1],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[1][0],
                    isThisBottomBarrier: false,
                  ),
                  // bottom barrier 1
                  MyBarrier(
                    barrierX: barrierX[1],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[1][1],
                    isThisBottomBarrier: true,
                  ),
                ],
              ),
            ),
            // ------------------------------ Score và High Score --------------------------------
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  // căn vị trí
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      // căn vị trí
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SCORE",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        SizedBox(height: 20),
                        Text(
                          score.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
