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
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 130,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    child: Text(
                      "rw",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Jhon Doe",
                        style: TextStyle(
                            color: white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "johndoe@gmail.com",
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                    ],
                  )
                ],
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
                SizedBox(
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
