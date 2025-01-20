import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/component/profile_component/my_profile_card.dart';
import 'package:ocash/widgets/component/profile_component/my_profileactivity_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: gray,
                  child: MyProfileCard(),
                ),
                Container(
                  color: black,
                  child: MyProfileactivityButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
