import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ocash/routes/my_app_route.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPhoto = ''.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        isLoggedIn.value = true;
        userName.value = user.displayName ?? 'Unknown User';
        userEmail.value = user.email ?? '';
        userPhoto.value = user.photoURL ?? '';
      } else {
        isLoggedIn.value = false;
        userName.value = '';
        userEmail.value = '';
        userPhoto.value = '';
      }
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

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        isLoggedIn.value = true;

        final user = userCredential.user;
        userName.value = user?.displayName ?? 'Unknown User';
        userEmail.value = user?.email ?? '';
        userPhoto.value = user?.photoURL ?? '';

        Get.snackbar('Success', 'Signed in as ${userName.value}');
        Get.offNamed(MyAppRoutes.dashboard);
      }
    } catch (e) {
      Get.snackbar('Error', 'Sign-in failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();

      userName.value = '';
      userEmail.value = '';
      userPhoto.value = '';
      isLoggedIn.value = false;

      Get.snackbar('Success', 'Logged out successfully');
      Get.offNamed(MyAppRoutes.loginPage);
    } catch (e) {
      Get.snackbar("Logout Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
