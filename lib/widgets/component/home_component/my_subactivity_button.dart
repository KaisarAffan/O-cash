import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_icon_button.dart';

class MySubactivityButton extends StatelessWidget {
  const MySubactivityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableIconButton(
            icon: Icons.electric_bolt,
            color: darkGray,
            text: 'Electricity',
            buttonWidth: 65,
            buttonHeight: 65,
            iconSize: 30,
            onPressed: () {}),
        ReusableIconButton(
            icon: Icons.wifi,
            color: darkGray,
            text: 'Internet',
            buttonWidth: 65,
            buttonHeight: 65,
            iconSize: 30,
            onPressed: () {}),
        ReusableIconButton(
            icon: Icons.store_mall_directory_outlined,
            color: darkGray,
            text: 'Merchant',
            buttonWidth: 65,
            buttonHeight: 65,
            iconSize: 30,
            onPressed: () {}),
        ReusableIconButton(
            icon: Icons.gamepad_outlined,
            color: darkGray,
            text: 'Games',
            buttonWidth: 65,
            buttonHeight: 65,
            iconSize: 30,
            onPressed: () {}),
        ReusableIconButton(
            icon: Icons.dashboard_customize_outlined,
            color: darkGray,
            text: 'More',
            buttonWidth: 65,
            buttonHeight: 65,
            iconSize: 30,
            onPressed: () {}),
      ],
    );
  }
}
