import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/component/finance_component/my_finantial_card.dart';
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
        margin: EdgeInsets.symmetric(horizontal: 16),
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
              height: 180,
              decoration: BoxDecoration(
                color: gray,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: const MyFinancialCard(),
              ),
            ),
            // Button Income/Outcome
          ],
        ),
      ),
    );
  }
}
