import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/routes/my_app_page.dart';
import 'package:ocash/routes/my_app_route.dart';
import 'package:ocash/utils/push-notification/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase here
  await NotificationController.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: MyAppPage.pages,
      initialRoute: MyAppRoutes.splashScreen, // Start at the login page
    );
  }
}
