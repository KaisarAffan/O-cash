import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/my_text.dart';

class MyHistoryCard extends StatelessWidget {
  final String title;
  final String? status;
  final String time;
  final String amount;
  final Color backgroundColor;
  final IconData icon;

  const MyHistoryCard({
    super.key,
    required this.title,
    this.status,
    required this.time,
    required this.amount,
    required this.backgroundColor,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: gray,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            const SizedBox(width: 16),
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
                      fontfamily: "Montserrat",
                      color: Colors.grey,
                      textAlign: TextAlign.left,
                    ),
                  MyText(
                    text: amount,
                    fontsize: 16,
                    fontfamily: "Montserratbold",
                    color: Colors.white,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyText(
                  text: time,
                  fontsize: 12,
                  fontfamily: "Montserrat",
                  color: Colors.grey,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
