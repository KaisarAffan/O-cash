import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/pages/login/controller.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_icon_button.dart';
import 'package:ocash/widgets/my_text.dart';

class MyProfileCard extends StatelessWidget {
  const MyProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(48),
          ),
          color: black),
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: loginController.userPhoto.value.isNotEmpty
                      ? NetworkImage(loginController.userPhoto.value)
                      : null,
                  child: loginController.userPhoto.value.isEmpty
                      ? Text(
                          loginController.userName.value.isNotEmpty
                              ? loginController.userName.value
                                  .substring(0, 2)
                                  .toUpperCase()
                              : 'NA',
                          style: TextStyle(fontSize: 40),
                        )
                      : null,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: loginController.userName.value,
                      fontsize: 24,
                      fontfamily: "MontserratBold",
                      color: white,
                      textAlign: TextAlign.center,
                    ),
                    MyText(
                      text: loginController.userEmail.value,
                      fontsize: 12,
                      fontfamily: "MontserratBold",
                      color: white,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Spacer(),
                ReusableIconButton(
                  icon: Icons.edit,
                  text: '',
                  buttonWidth: 64,
                  buttonHeight: 64,
                  iconSize: 32,
                  onPressed: () {},
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
