import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/services/googlesignin_service.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_profile_button.dart';
import 'package:ocash/widgets/my_color.dart';

class MyProfileactivityButton extends StatelessWidget {
  const MyProfileactivityButton({super.key});

  @override
  Widget build(BuildContext context) {
    final GoogleSignInController googleSignInController =
        Get.put(GoogleSignInController());

    return Container(
      decoration: BoxDecoration(
        color: greys,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(48),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Account Settings",
                  style: TextStyle(color: white, fontSize: 18),
                ),
                SizedBox(
                  height: 6,
                ),
                MyProfileButton(
                  text: "Account Info",
                  onPressed: () {},
                  padding: EdgeInsets.all(15),
                  border: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: white,
                  icon: Icons.person,
                ),
                MyProfileButton(
                  text: "Login and security",
                  onPressed: () {},
                  padding: EdgeInsets.all(15),
                  border: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: white,
                  icon: Icons.shield_outlined,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Other",
                  style: TextStyle(color: white, fontSize: 18),
                ),
                SizedBox(
                  height: 6,
                ),
                MyProfileButton(
                  text: "Help center",
                  onPressed: () {},
                  padding: EdgeInsets.all(15),
                  border: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: white,
                  icon: Icons.call,
                ),
                MyProfileButton(
                  text: "About app",
                  onPressed: () {},
                  padding: EdgeInsets.all(15),
                  border: BorderRadius.only(),
                  color: white,
                  icon: Icons.info_outline,
                ),
                MyProfileButton(
                  text: "Log Out",
                  onPressed: () {
                    googleSignInController.logout();
                  },
                  padding: EdgeInsets.all(15),
                  border: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: red,
                  icon: Icons.logout,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
