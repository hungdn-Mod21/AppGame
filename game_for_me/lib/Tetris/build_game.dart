import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:game_for_me/Tetris/sub_block.dart';
import 'block.dart';
import 'dart:async';
import 'dart:math';

class GameState extends StatefulWidget {
  const GameState({super.key});

  @override
  State<GameState> createState() => GameStateState();
}

// số lượng khối
const blockX = 10;
const blockY = 20;

const REFRESH_RATE = 300;

const GAME_AREA_BORDER_WIDTH = 2.0;

const SUB_BLOCK_EDGE_WIDTH = 2.0;

class GameStateState extends State<GameState> {
  late double subBlockWidth;

  Duration duration = Duration(milliseconds: REFRESH_RATE);

  GlobalKey _keyGameArea = GlobalKey();

  late Block block;
  late Timer timer;
  bool isPlaying = false;

  Block getNewBlock() {
    int blockType = Random().nextInt(7);
    int orientationIndex = Random().nextInt(4);

    switch (blockType) {
      case 0:
        return IBlock(orientationIndex);
      case 1:
        return JBlock(orientationIndex);
      case 2:
        return LBlock(orientationIndex);
      case 3:
        return OBlock(orientationIndex);
      case 4:
        return TBlock(orientationIndex);
      case 5:
        return SBlock(orientationIndex);
      case 6:
        return ZBlock(orientationIndex);
      default:
        return null!;
    }
  }

  void startGame() {
    isPlaying = true;
    final RenderBox renderBoxGame =
        _keyGameArea.currentContext!.findRenderObject() as RenderBox;
    subBlockWidth =
        (renderBoxGame.size.width - GAME_AREA_BORDER_WIDTH * 2) / blockX;
    block = getNewBlock();

    timer = Timer.periodic(duration, onPlay);
  }

  void endGame() {
    isPlaying = false;
    timer.cancel();
  }

  onPlay(Timer timer) {
    setState(() {
      block.move(BlockMovement.DOWN);
    });
  }

  Widget getPositionedSquareContainer(
      {required Color color, required int x, required int y}) {
    return Positioned(
      left: x * subBlockWidth,
      top: y * subBlockWidth,
      child: Container(
        width: subBlockWidth - SUB_BLOCK_EDGE_WIDTH,
        height: subBlockWidth - SUB_BLOCK_EDGE_WIDTH,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(const Radius.circular(3.0)),
        ),
      ),
    );
  }

  Widget drawBlocks() {
    if (block == null) return null!;
    List<Positioned> subBlocks = [];

    // Current block
    block.SubBlocks.forEach((subBlock) {
      subBlocks.add(Positioned(
        left: subBlock.x * subBlockWidth,
        top: subBlock.y * subBlockWidth,
        child: Container(
          width: subBlockWidth - SUB_BLOCK_EDGE_WIDTH,
          height: subBlockWidth - SUB_BLOCK_EDGE_WIDTH,
          decoration: BoxDecoration(
            color: subBlock.color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(const Radius.circular(3.0)),
          ),
        ),
      ));
    });

    return Stack(
      children: subBlocks,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      // AspectRatio(tỷ lệ khung hình)
      aspectRatio: blockX / blockY, // chia ty le
      child: Container(
        key: _keyGameArea,
        decoration: BoxDecoration(
          color: Colors.indigo[700],
          border: Border.all(
            width: 2.0,
            color: Colors.indigoAccent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: drawBlocks(),
      ),
    );
  }
}
