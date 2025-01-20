import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/pages/login/controller.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/component/home_component/my_balance_card.dart';
import 'package:ocash/widgets/component/home_component/my_mainactivity_button.dart';
import 'package:ocash/widgets/component/home_component/my_mainhome_activity.dart';
import 'package:ocash/widgets/my_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LoginController loginController = Get.put(LoginController());
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
              MyBalanceCard(),
              Container(
                height: 105,
                margin: EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(color: darkGray),
                child: MyMainactivityButton(),
              ),
              MyMainHomeActivity()
            ],
          ),
        ),
      ),
    );
  }
}
