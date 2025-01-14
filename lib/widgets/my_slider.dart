// my_slider.dart
import 'package:flutter/material.dart';
import 'my_text.dart';

class MySlider extends StatelessWidget {
  final String img;
  final String title;
  final String description;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;

  const MySlider({
    Key? key,
    required this.img,
    required this.title,
    required this.description,
    required this.titleStyle,
    required this.descriptionStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        MyText(
          text: title,
          style: titleStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Image.asset(
          img,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),
        MyText(
          text: description,
          style: descriptionStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
