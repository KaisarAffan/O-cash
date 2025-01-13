import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ocash/utils/color_pallete.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Column(
          children: [
            Container(
              height: 130,
              child: Row(
                children: [],
              ),
            ),
            Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/Union.svg',
                  width: MediaQuery.of(context).size.width,
                  height: 722,
                  fit: BoxFit
                      .cover, // Ensures the SVG covers the entire background
                ),
                Container(
                  height: 722,
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
