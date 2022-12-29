import 'package:game_for_me/Tetris/build_game.dart';
import 'package:game_for_me/Tetris/next_block.dart';
import 'package:game_for_me/Tetris/score_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Tetris extends StatefulWidget {
  const Tetris({super.key});

  @override
  State<Tetris> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  GlobalKey<GameState> _keyGame = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text("TETRIS"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ScoreBar(),
            Expanded(
              child: Center(
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // vị trí nội dung (trục phụ)
                  children: [
                    Flexible(
                      flex: 3, // chia phần
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
                        child: GameState(key: _keyGame,),
                      ),
                    ),
                    Flexible(
                      flex: 1, // chia phần
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // thu nhỏ kích thước
                          children: [
                            NextBlock(),
                            SizedBox(
                              height: 30,
                            ),
                            // --- Nút Start ---
                            ElevatedButton(
                              // trang trí nút
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors
                                    .green), // MaterialStateProperty(tài sản trạng thái vật chất)
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20),
                                ),
                                textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  //istapped = 'Button tapped';
                                });
                              },
                              child: Text(
                                _keyGame.currentContext != null && _keyGame.currentState ? 'End' :
                                'Start'),
                            ),
                          ],
                        ),
                      ),
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
