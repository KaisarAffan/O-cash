import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/my_text.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final double fontSize;

  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.padding,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: MyText(
          text: text,
          fontsize: 16,
          fontfamily: "MontserratBold",
          color: white,
          textAlign: TextAlign.center),
    );
  }
}
