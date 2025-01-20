import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/my_text.dart';

class MyHistoryactivityButton extends StatelessWidget {
  const MyHistoryactivityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 64,
              height: 56,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: gray,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: Icon(
                  Icons.search,
                  size: 32,
                  color: white,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 112,
              height: 56,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: gray,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                children: [
                  MyText(
                      text: "Sort",
                      fontsize: 20,
                      fontfamily: "MontserratBold",
                      color: white,
                      textAlign: TextAlign.center),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.sort,
                    size: 32,
                    color: white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
