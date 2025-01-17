import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/pages/login/controller.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_icon_button.dart';
import 'package:ocash/widgets/component/home_component/my_mainactivity_button.dart';
import 'package:ocash/widgets/component/home_component/my_subactivity_button.dart';
import 'package:ocash/widgets/my_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LoginController loginController = Get.put(LoginController());
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    MyText(
                      text: 'Welcome',
                      fontsize: 16,
                      color: white,
                      fontfamily: "MontserratSemi",
                      textAlign: TextAlign.center,
                    ),
                    MyText(
                      text:
                          '${loginController.auth.currentUser?.displayName ?? 'User'}',
                      fontsize: 24,
                      color: white,
                      fontfamily: "MontserratBold",
                      textAlign: TextAlign.center,
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
                                      text: isBalanceHidden
                                          ? '*******'
                                          : '1.700.000',
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
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
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
              ),
              Container(
                height: 105,
                margin: EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(color: Color(0xff232323)),
                child: MyMainactivityButton(),
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
                      MySubactivityButton(),
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
