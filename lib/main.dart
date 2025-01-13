import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/routes/my_app_page.dart';
import 'package:ocash/routes/my_app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: MyAppPage.pages,
      initialRoute: MyAppRoutes.dashboard,
    );
  }
}
