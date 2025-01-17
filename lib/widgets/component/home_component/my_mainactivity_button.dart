import 'package:flutter/material.dart';
import 'package:ocash/widgets/button/my_icon_button.dart';

class MyMainactivityButton extends StatelessWidget {
  const MyMainactivityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            child: ReusableIconButton(
                icon: Icons.add_circle_outline,
                text: 'Top Up',
                buttonWidth: 90,
                buttonHeight: 60,
                iconSize: 30,
                onPressed: () {})),
        Container(
            child: ReusableIconButton(
                icon: Icons.arrow_circle_down_rounded,
                text: 'Transfer',
                buttonWidth: 90,
                buttonHeight: 60,
                iconSize: 30,
                onPressed: () {})),
        Container(
            child: ReusableIconButton(
                icon: Icons.arrow_circle_down_rounded,
                text: 'Request',
                buttonWidth: 90,
                buttonHeight: 60,
                iconSize: 30,
                onPressed: () {}))
      ],
    );
  }
}
