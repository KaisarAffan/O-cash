import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'controller.dart'; // Import your login controller

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          if (loginController.isLoading.value) {
            return const CircularProgressIndicator();
          } else {
            return ElevatedButton(
              onPressed: loginController.loginWithGoogle,
              child: const Text('Sign In with Google'),
            );
          }
        }),
      ),
    );
  }
}
