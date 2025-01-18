// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocash/pages/home/home.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_button.dart';
import 'package:ocash/widgets/my_color.dart';
import 'package:ocash/widgets/my_text.dart';
import 'package:ocash/widgets/my_textfield.dart';
import 'controller.dart'; // Import your login controller

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greys,
      body: Center(
        child: Obx(() {
          if (loginController.isLoading.value) {
            return const CircularProgressIndicator();
          } else {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 104),
                  height: 100,
                  width: 306,
                  child: SvgPicture.asset(
                    'assets/images/Ocash-logo.svg',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: MyText(
                            text: "Username",
                            fontsize: 16,
                            fontfamily: "MontserratBold",
                            color: white,
                            textAlign: TextAlign.left),
                      ),
                      MyEditText(controller: null),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: MyText(
                          text: "Password",
                          color: white,
                          fontsize: 16,
                          fontfamily: "MontserratBold",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      MyEditText(controller: null),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: MyText(
                          text: "Forgot Password?",
                          color: orange,
                          fontsize: 14,
                          fontfamily: "MontserratBold",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child: MyButton(
                          text: "Sign In",
                          onPressed: () {},
                          backgroundColor: orange,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: orange,
                  height: 2,
                  indent: 16,
                  endIndent: 16,
                ),
                SizedBox(height: 8),
                Text(
                  "or",
                  style: TextStyle(
                      color: white, fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/images/google-icon.svg',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Continue With Google",
                          style: TextStyle(
                              fontSize: 16,
                              color: greys,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onPressed: () {
                      loginController.loginWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: orange, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
