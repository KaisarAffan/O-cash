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
            return Column(
              children: [
                if (!loginController.isLoggedIn
                    .value) // Show sign-in button only if not logged in
                  ElevatedButton(
                    onPressed: loginController.loginWithGoogle,
                    child: const Text('Sign In with Google'),
                  ),
                if (loginController
                    .isLoggedIn.value) // Show logout button only if logged in
                  ElevatedButton(
                    onPressed: () async {
                      await loginController.logout();
                    },
                    child: const Text('Logout'),
                  ),
                const SizedBox(height: 20), // Add some spacing
                // Display login status message
                Text(
                  loginController.isLoggedIn.value
                      ? 'Sudah Login'
                      : 'Belum Login',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
