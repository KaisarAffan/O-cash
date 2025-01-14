import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((User? user) {
      isLoggedIn.value = user != null;
    });
  }

  Future<void> loginWithGoogle() async {
    isLoading.value = true;

    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        final GoogleSignInAuthentication googleAuth =
            await account.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        isLoggedIn.value = true;

        Get.snackbar('Success', 'Signed in as ${account.displayName}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Sign-in failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await googleSignIn.signOut(); // Sign out from Google
      await auth.signOut(); // Sign out from Firebase
      isLoggedIn.value = false; // Update login state

      // Navigate back to Login Page
      Get.snackbar('Success', 'Logged out successfully');
    } catch (e) {
      Get.snackbar("Logout Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
