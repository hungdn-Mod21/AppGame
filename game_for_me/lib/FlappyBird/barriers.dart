import 'package:flutter/material.dart';

//----------------------------- Rào Cản ---------------------------------
class MyBarrier extends StatelessWidget {
  // // kích thước
  // final size;

  // // Contructer
  // MyBarrier({this.size});

  final barrierWidth;  // c rộng
  final barrierHeight;  // c cao
  final barrierX; // toạ độ barrier
  final bool isThisBottomBarrier;  // kiểm tra có phải dào cản dưới cùng

  MyBarrier(
      {this.barrierHeight,
      this.barrierWidth,
      required this.isThisBottomBarrier,
      this.barrierX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarrier ? 1 : -1),  // nếu là dào cản dưới cùng
      child: Container(
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: isThisBottomBarrier? BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)
          ) : BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
          ),
        ),
      ),
    );

    // return Container(
    //   width: MediaQuery.of(context).size.width / 4,
    //   height: size,
    //   decoration: BoxDecoration(
    //     color: Colors.green,
    //     border: Border.all(width: 1, color: Colors.black),
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    // );
  }
}
