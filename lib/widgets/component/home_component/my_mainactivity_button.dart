import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/routes/my_app_route.dart';
import 'package:ocash/utils/color_pallete.dart';
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
                color: gray,
                text: 'Top Up',
                buttonWidth: 90,
                buttonHeight: 60,
                iconSize: 30,
                onPressed: () {
                  Get.toNamed(MyAppRoutes.topUpPage);
                })),
        Container(
            child: ReusableIconButton(
                icon: Icons.arrow_circle_down_rounded,
                color: gray,
                text: 'Transfer',
                buttonWidth: 90,
                buttonHeight: 60,
                iconSize: 30,
                onPressed: () {
                  Get.toNamed(MyAppRoutes.transferPage);
                })),
        Container(
            child: ReusableIconButton(
                icon: Icons.arrow_circle_down_rounded,
                color: gray,
                text: 'Request',
                buttonWidth: 90,
                buttonHeight: 60,
                iconSize: 30,
                onPressed: () {}))
      ],
    );
  }
}
