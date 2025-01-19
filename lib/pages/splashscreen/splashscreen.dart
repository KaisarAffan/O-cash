import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ocash/routes/my_app_route.dart';
import 'package:ocash/utils/color_pallete.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(MyAppRoutes.introPage);
    });

    return Scaffold(
      backgroundColor: gray,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/ocash-logo.svg',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
