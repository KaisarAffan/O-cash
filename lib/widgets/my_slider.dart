// my_slider.dart
import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'my_text.dart';

class MySlider extends StatelessWidget {
  final String img;
  final String title;
  final String description;

  const MySlider({
    Key? key,
    required this.img,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 96),
          MyText(
              text: title,
              fontsize: 24,
              fontfamily: "MontserratBold",
              color: white,
              textAlign: TextAlign.center),
          SizedBox(height: 24),
          Image.asset(
            img,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 24),
          MyText(
              text: description,
              fontsize: 16,
              fontfamily: 'MontserratBold',
              color: white,
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
