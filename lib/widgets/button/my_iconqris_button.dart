import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/my_text.dart';

class MyIconQrisButton extends StatelessWidget {
  final double fontsize;
  final double paddingHorizontal;
  final double paddingVertical;
  final GestureTapCallback onPressed;
  final Color backgroundColor;
  final IconData iconData;
  final String text;

  const MyIconQrisButton({
    super.key,
    required this.fontsize,
    required this.backgroundColor,
    required this.iconData,
    required this.text,
    this.paddingHorizontal = 16,
    this.paddingVertical = 24,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 144,
        height: 120,
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        decoration: BoxDecoration(
          color: darkGray,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            Icon(
              iconData,
              size: 36,
              color: white,
            ),
            SizedBox(height: 16),
            MyText(
              text: text,
              fontsize: fontsize,
              fontfamily: "MontserratBold",
              color: white,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
