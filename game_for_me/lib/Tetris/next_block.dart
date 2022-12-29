import 'package:flutter/material.dart';

class NextBlock extends StatefulWidget {
  const NextBlock({super.key});

  @override
  State<NextBlock> createState() => _NextBlockState();
}

class _NextBlockState extends State<NextBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      width: double.infinity,
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,  // thu nhỏ hết kích thước lại
        children: [
          Text(
            "Next",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          AspectRatio(   
            aspectRatio: 1,    // chia tỷ lệ khung hình
            child: Container(
              color: Colors.indigo[600],
            ),
          ),
        ],
      ),
    );
  }
}
