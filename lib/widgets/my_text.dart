import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double fontsize;
  final String fontfamily;
  final Color color;
  final TextAlign textAlign;

  const MyText({
    super.key,
    required this.text,
    required this.fontsize,
    required this.fontfamily,
    required this.color, required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        textAlign: textAlign,
        text,
        style: TextStyle(
          fontFamily: fontfamily,
          fontSize: fontsize,
          color: color,
        ),
      ),
    );
  }
}