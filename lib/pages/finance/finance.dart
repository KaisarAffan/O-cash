import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_button.dart';
import 'package:ocash/widgets/button/my_icon_button.dart';
import 'package:ocash/widgets/button/profile_button.dart';
import 'package:ocash/widgets/my_text.dart';

class Finance extends StatefulWidget {
  const Finance({super.key});

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  bool isBalanceHidden = false;

  void toggleBalanceVisibility() {
    setState(() {
      isBalanceHidden = !isBalanceHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            MyText(
                text: 'Finance',
                fontsize: 32,
                fontfamily: 'MontserratBold',
                color: white,
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
            // Finance Balance
            Container(
              width: MediaQuery.of(context).size.width,
              height: 164,
              decoration: BoxDecoration(
                  color: gray, borderRadius: BorderRadius.circular(5)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                                text: 'Financial records',
                                fontsize: 16,
                                fontfamily: 'MontserratBold',
                                color: white,
                                textAlign: TextAlign.start),
                            MyText(
                                text: '1 Jan 2025 - 31 Jan 2025',
                                fontsize: 10,
                                fontfamily: 'MontserratMedi',
                                color: white,
                                textAlign: TextAlign.start),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            toggleBalanceVisibility();
                          },
                          child: Container(
                            child: Icon(
                              isBalanceHidden
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 30,
                              color: white,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 55,
                          width: 161,
                          decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                    text: 'Income',
                                    fontsize: 12,
                                    fontfamily: 'MontserratMedi',
                                    color: white,
                                    textAlign: TextAlign.start),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Rp.',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: "MontserratMedi",
                                            fontSize: 14),
                                      ),
                                      TextSpan(
                                        text: isBalanceHidden
                                            ? '2.000.000'
                                            : '*******',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: 'MontserratBold',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 55,
                          width: 161,
                          decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                    text: 'Outcome',
                                    fontsize: 12,
                                    fontfamily: 'MontserratMedi',
                                    color: white,
                                    textAlign: TextAlign.start),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Rp.',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: "MontserratMedi",
                                            fontSize: 14),
                                      ),
                                      TextSpan(
                                        text: isBalanceHidden
                                            ? '300.000'
                                            : '*******',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: 'MontserratBold',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                                text: 'Balance',
                                fontsize: 12,
                                fontfamily: 'MontserratMedi',
                                color: white,
                                textAlign: TextAlign.start),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Rp.',
                                    style: TextStyle(
                                        color: white,
                                        fontFamily: "MontserratMedi",
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: isBalanceHidden
                                        ? '1.700.000'
                                        : '*******',
                                    style: TextStyle(
                                        color: white,
                                        fontFamily: 'MontserratBold',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Button Income/Outcome
          ],
        ),
      ),
    );
  }
}
