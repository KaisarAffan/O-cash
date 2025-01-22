import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/my_color.dart';
import 'package:ocash/widgets/my_text.dart';

class MyHistoryCard extends StatelessWidget {
  final String title;
  final String type;
  final String timeHours;
  final String timeDay;
  final String amount;
  final IconData icon;

  const MyHistoryCard({
    super.key,
    required this.title,
    required this.type,
    required this.timeHours,
    required this.timeDay,
    required this.amount,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: gray,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: gray,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: Icon(
                icon,
                color: white,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: title,
                    fontsize: 16,
                    fontfamily: "MontserratBold",
                    color: Colors.white,
                    textAlign: TextAlign.left,
                  ),
                  MyText(
                    text: type,
                    fontsize: 14,
                    fontfamily: "MontserratSemi",
                    color: Colors.grey,
                    textAlign: TextAlign.left,
                  ),
                  MyText(
                    text: amount,
                    fontsize: 16,
                    fontfamily: "MontserratBold",
                    color: Colors.white,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              width: 120,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: timeHours,
                    fontsize: 14,
                    fontfamily: "MontserratMedi",
                    color: Colors.grey,
                    textAlign: TextAlign.right,
                  ),
                  MyText(
                      text: timeDay,
                      fontsize: 14,
                      fontfamily: "MontserratMedi",
                      color: Colors.grey,
                      textAlign: TextAlign.right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
