import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';

class ReusableIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final double buttonWidth;
  final double buttonHeight;
  final double iconSize;
  final Color color;
  final VoidCallback onPressed;

  const ReusableIconButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.buttonWidth,
      required this.buttonHeight,
      required this.iconSize,
      required this.onPressed,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: buttonWidth,
            height: buttonHeight,
            decoration: BoxDecoration(
              color: color,
              shape: buttonWidth == buttonHeight
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              borderRadius: buttonWidth == buttonHeight
                  ? null
                  : BorderRadius.circular(buttonHeight / 2),
            ),
            child: Center(
              child: Icon(
                icon,
                size: iconSize,
                color: white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
