import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';

class MyProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final BorderRadiusGeometry border;
  final Color color;
  final IconData icon;

  const MyProfileButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.padding,
    this.fontSize = 16,
    required this.border,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: darkGray,
        shape: RoundedRectangleBorder(
          borderRadius: border,
        ),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
        size: 26,
      ),
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: fontSize,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: color,
          )
        ],
      ),
    );
  }
}
