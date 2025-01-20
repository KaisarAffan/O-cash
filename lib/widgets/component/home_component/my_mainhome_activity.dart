import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/component/home_component/my_carouselpromo_card.dart';
import 'package:ocash/widgets/component/home_component/my_subactivity_button.dart';

class MyMainHomeActivity extends StatelessWidget {
  const MyMainHomeActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 527,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: gray,
          border: Border(
            top: BorderSide(color: Color(0xff8A8A8A), width: 1),
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              'Payment',
              style: TextStyle(
                  fontSize: 20, color: white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 11,
            ),
            MySubactivityButton(),
            SizedBox(
              height: 16,
            ),
            Text(
              'Promo',
              style: TextStyle(
                  fontSize: 20, color: white, fontWeight: FontWeight.bold),
            ),
            MyCarouselpromo()
          ],
        ),
      ),
    );
  }
}
