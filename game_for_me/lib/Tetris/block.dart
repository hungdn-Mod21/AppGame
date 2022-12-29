import 'package:flutter/material.dart';
// thư viện hỗ trợ block
import 'sub_block.dart';

enum BlockMovement {
  UP,
  DOWN,
  LEFT,
  RIGHT,
  ROTAGE_CLOCKWISE,
  ROTAGE_COUNTER_CLOCKWISE
}

class Block {
  List<List<SubBlock>> orientations = [];

  late int x;
  late int y;
  late int orientationIndex;

  var subBlocks;

  Block(
      {required this.orientations,
      required Color color,
      required this.orientationIndex}) {
    x = 3;
    y = -Width - 1;
    this.colorSet = color;
  }

  set colorSet(Color color) {
    orientations.forEach((orientation) {
      orientation.forEach((subBlock) {
        subBlock.color = color;
      });
    });
  }

  get colorGet {
    return orientations[0][0];
  }

  get SubBlocks {
    return orientations[orientationIndex];
  }

  get Width {
    int maxX = 0;
    SubBlocks.forEach((subBlock) {
      if (subBlock.x > maxX) {
        maxX = subBlock.x;
      }
    });
    return maxX + 1;
  }

  get Height {
    int maxY = 0;
    SubBlocks.forEach((subBlock) {
      if (subBlock.y > maxY) {
        maxY = subBlock.y;
      }
    });
    return maxY + 1;
  }

  void move(BlockMovement blockMovement) {
    switch (blockMovement) {
      case BlockMovement.UP:
        y -= 1;
        break;
      case BlockMovement.DOWN:
        y += 1;
        break;
      case BlockMovement.LEFT:
        x -= 1;
        break;
      case BlockMovement.RIGHT:
        x += 1;
        break;
      case BlockMovement.ROTAGE_CLOCKWISE:
        orientationIndex = ++orientationIndex % 4;
        break;
      case BlockMovement.ROTAGE_COUNTER_CLOCKWISE:
        orientationIndex = (orientationIndex + 3) % 4;
        break;
    }
  }
}

class IBlock extends Block {
  IBlock(int orientationIndex)
      : super(
          color: Colors.red.shade300,
          orientationIndex: orientationIndex,
          orientations: [
            [SubBlock(0, 0), SubBlock(0, 1), SubBlock(0, 2), SubBlock(0, 3)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(3, 0)],
            [SubBlock(0, 0), SubBlock(0, 1), SubBlock(0, 2), SubBlock(0, 3)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(3, 0)],
          ],
        );
}

class JBlock extends Block {
  JBlock(int orientationIndex)
      : super(
          color: Colors.yellow.shade300,
          orientationIndex: orientationIndex,
          orientations: [
            [SubBlock(1, 0), SubBlock(1, 1), SubBlock(1, 2), SubBlock(0, 2)],
            [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(2, 1)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(0, 2)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(2, 1)],
          ],
        );
}

class LBlock extends Block {
  LBlock(int orientationIndex)
      : super(
          color: Colors.green.shade300,
          orientationIndex: orientationIndex,
          orientations: [
            [SubBlock(0, 0), SubBlock(0, 1), SubBlock(0, 2), SubBlock(1, 2)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(2, 1)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(0, 2)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(2, 1)],
          ],
        );
}

class OBlock extends Block {
  OBlock(int orientationIndex)
      : super(
          color: Colors.blue.shade300,
          orientationIndex: orientationIndex,
          orientations: [
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
          ],
        );
}

class TBlock extends Block {
  TBlock(int orientationIndex)
      : super(
          color: Colors.pink.shade300,
          orientationIndex: orientationIndex,
          orientations: [
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(1, 1)],
            [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(1, 2)],
            [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(2, 1)],
            [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
          ],
        );
}

class SBlock extends Block {
  SBlock(int orientationIndex)
      : super(
          color: Colors.brown.shade300,
          orientationIndex: orientationIndex,
          orientations: [
            [SubBlock(1, 0), SubBlock(2, 0), SubBlock(0, 1), SubBlock(1, 1)],
            [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(1, 2)],
            [SubBlock(1, 0), SubBlock(2, 0), SubBlock(0, 1), SubBlock(1, 1)],
            [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(1, 2)],
          ],
        );
}

class ZBlock extends Block {
  ZBlock(int orientationIndex)
      : super(
          color: Colors.cyan.shade300,
          orientationIndex: orientationIndex,
          orientations: [
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(2, 1)],
            [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
            [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(2, 1)],
            [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
          ],
        );
}
