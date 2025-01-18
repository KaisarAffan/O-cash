import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/my_text.dart';

class MyHistoryCard extends StatelessWidget {
  final String title;
  final String? status;
  final String time;
  final String amount;
  final IconData icon;

  const MyHistoryCard({
    super.key,
    required this.title,
    this.status,
    required this.time,
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
                  if (status != null)
                    MyText(
                      text: status!,
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
            MyText(
              text: time,
              fontsize: 16,
              fontfamily: "MontserratMedi",
              color: Colors.grey,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
