import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_icon_button.dart';
import 'package:ocash/widgets/my_text.dart';

class MyBalanceCard extends StatefulWidget {
  const MyBalanceCard({super.key});

  @override
  State<MyBalanceCard> createState() => _MyBalanceCardState();
}

class _MyBalanceCardState extends State<MyBalanceCard> {
  bool isBalanceHidden = false;

  void toggleBalanceVisibility() {
    setState(() {
      isBalanceHidden = !isBalanceHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 130,
          margin: EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
              color: Color(0xff232323),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        ),
        Container(
          height: 130,
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: green, borderRadius: BorderRadius.circular(45)),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: 'Balance',
                      fontsize: 20,
                      color: black,
                      fontfamily: "MontserratSemi",
                      textAlign: TextAlign.center,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Rp.',
                            style: TextStyle(
                                color: black,
                                fontFamily: "MontserratMedi",
                                fontSize: 32),
                          ),
                          TextSpan(
                            text: isBalanceHidden ? '1.700.000' : '*******',
                            style: TextStyle(
                                color: black,
                                fontFamily: 'MontserratBold',
                                fontSize: 32),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ReusableIconButton(
                  icon: isBalanceHidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  text: '',
                  buttonWidth: 40,
                  buttonHeight: 40,
                  iconSize: 37,
                  onPressed: toggleBalanceVisibility,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
