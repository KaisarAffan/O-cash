import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_iconqris_button.dart';
import 'package:ocash/widgets/my_color.dart';

class MyQrisView extends StatelessWidget {
  const MyQrisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 24,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              Image.asset(
                'assets/images/qris-logo.png',
                width: 100,
                height: 40,
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.image_rounded, color: Colors.white),
                    iconSize: 32,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.flash_off_outlined, color: Colors.white),
                    iconSize: 32,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        // QR Overlay
        Container(
          margin: EdgeInsets.only(bottom: 212),
          child: Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: greys, width: 4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  border: Border.all(color: greys, width: 4),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
        // Bottom Buttons
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 212,
            decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )),
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyIconQrisButton(
                  onPressed: () {},
                  fontsize: 16,
                  backgroundColor: darkGray,
                  iconData: Icons.qr_code_2_rounded,
                  text: "Show QR",
                ),
                MyIconQrisButton(
                  onPressed: () {},
                  fontsize: 16,
                  backgroundColor: darkGray,
                  iconData: Icons.attach_money_rounded,
                  text: "Transfer Bank",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
