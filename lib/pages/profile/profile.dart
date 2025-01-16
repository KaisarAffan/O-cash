import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ocash/pages/login/controller.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_icon_button.dart';
import 'package:ocash/widgets/button/profile_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                  height: 110,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Text(
                              "jd",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "John Doe",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "johndoe@gmail.com",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 29,
                          ),
                          ReusableIconButton(
                              icon: Icons.edit,
                              text: '',
                              buttonWidth: 50,
                              buttonHeight: 50,
                              iconSize: 30,
                              onPressed: () {},
                              color: Colors.transparent),
                        ],
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/Union.svg',
                      width: MediaQuery.of(context).size.width,
                      height: 735,
                      fit: BoxFit.cover,
                    ),
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
                          ProfileButton(
                            text: "Account Info",
                            onPressed: () {},
                            padding: EdgeInsets.all(15),
                            border: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            color: white,
                            icon: Icons.person,
                          ),
                          ProfileButton(
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
                          ProfileButton(
                            text: "Help center",
                            onPressed: () {},
                            padding: EdgeInsets.all(15),
                            border: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            color: white,
                            icon: Icons.call,
                          ),
                          ProfileButton(
                            text: "About app",
                            onPressed: () {},
                            padding: EdgeInsets.all(15),
                            border: BorderRadius.only(),
                            color: white,
                            icon: Icons.info_outline,
                          ),
                          ProfileButton(
                            text: "Log Out",
                            onPressed: () {
                              loginController.logout();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
