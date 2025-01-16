import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_icon_button.dart';
import 'package:ocash/widgets/my_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 16,
                          color: white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'John Doe',
                      style: TextStyle(
                          fontSize: 24,
                          color: white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 130,
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    decoration: BoxDecoration(
                        color: Color(0xff232323),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45))),
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
                              Text(
                                'Balance',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Rp.1,700,000',
                                style: TextStyle(
                                    fontSize: 32,
                                    color: black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          ReusableIconButton(
                              icon: Icons.visibility_outlined,
                              text: '',
                              buttonWidth: 40,
                              buttonHeight: 40,
                              iconSize: 37,
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 105,
                margin: EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(color: Color(0xff232323)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: ReusableIconButton(
                            icon: Icons.add_circle_outline,
                            text: 'Top Up',
                            buttonWidth: 90,
                            buttonHeight: 60,
                            iconSize: 30,
                            onPressed: () {})),
                    Container(
                        child: ReusableIconButton(
                            icon: Icons.arrow_circle_down_rounded,
                            text: 'Transfer',
                            buttonWidth: 90,
                            buttonHeight: 60,
                            iconSize: 30,
                            onPressed: () {})),
                    Container(
                        child: ReusableIconButton(
                            icon: Icons.arrow_circle_down_rounded,
                            text: 'Request',
                            buttonWidth: 90,
                            buttonHeight: 60,
                            iconSize: 30,
                            onPressed: () {}))
                  ],
                ),
              ),
              Container(
                height: 527,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: gray,
                    border: Border(
                        top: BorderSide(color: Color(0xff8A8A8A), width: 1)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Payment',
                        style: TextStyle(
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableIconButton(
                              icon: Icons.electric_bolt,
                              text: 'Electricity',
                              buttonWidth: 65,
                              buttonHeight: 65,
                              iconSize: 30,
                              onPressed: () {}),
                          ReusableIconButton(
                              icon: Icons.wifi,
                              text: 'Internet',
                              buttonWidth: 65,
                              buttonHeight: 65,
                              iconSize: 30,
                              onPressed: () {}),
                          ReusableIconButton(
                              icon: Icons.store_mall_directory_outlined,
                              text: 'Merchant',
                              buttonWidth: 65,
                              buttonHeight: 65,
                              iconSize: 30,
                              onPressed: () {}),
                          ReusableIconButton(
                              icon: Icons.gamepad_outlined,
                              text: 'Games',
                              buttonWidth: 65,
                              buttonHeight: 65,
                              iconSize: 30,
                              onPressed: () {}),
                          ReusableIconButton(
                              icon: Icons.dashboard_customize_outlined,
                              text: 'More',
                              buttonWidth: 65,
                              buttonHeight: 65,
                              iconSize: 30,
                              onPressed: () {}),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Promo',
                        style: TextStyle(
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
