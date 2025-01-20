import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/my_text.dart';

class MyFinancialCard extends StatefulWidget {
  const MyFinancialCard({super.key});

  @override
  State<MyFinancialCard> createState() => _MyFinancialCardState();
}

class _MyFinancialCardState extends State<MyFinancialCard> {
  bool isBalanceHidden = false;

  void toggleBalanceVisibility() {
    setState(() {
      isBalanceHidden = !isBalanceHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Expanded(
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                    color: black, borderRadius: BorderRadius.circular(8)),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                          text: 'Income',
                          fontsize: 14,
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
                              text: isBalanceHidden ? '2.000.000' : '*******',
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
                ),
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                    color: black, borderRadius: BorderRadius.circular(8)),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                          text: 'Outcome',
                          fontsize: 14,
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
                              text: isBalanceHidden ? '300.000' : '*******',
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
                    fontsize: 14,
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
                        text: isBalanceHidden ? '1.700.000' : '*******',
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
    );
  }
}
