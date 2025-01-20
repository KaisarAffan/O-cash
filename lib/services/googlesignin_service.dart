import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ocash/pages/home/controller.dart';
import 'package:ocash/routes/my_app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInController extends GetxController {
  var currentUser = Rxn<User>();

  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    auth.authStateChanges().listen((User? user) {
      currentUser.value = user;
      isLoggedIn.value = user != null;
    });
  }

  String get displayName => currentUser.value?.displayName ?? 'Unknown User';
  String get email => currentUser.value?.email ?? '';
  String get photoURL => currentUser.value?.photoURL ?? '';

  void handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        Get.snackbar('Error', 'Account exists with a different credential.');
        break;
      case 'invalid-credential':
        Get.snackbar('Error', 'Invalid credential provided.');
        break;
      default:
        Get.snackbar('Error', 'Authentication failed: ${e.message}');
    }
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
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

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        isLoggedIn.value = true;

        final user = userCredential.user;

        final CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        DocumentSnapshot userDoc = await users.doc(user?.uid).get();

        if (userDoc.exists) {
          await users.doc(user?.uid).update(
            {
              'lastSignIn': FieldValue.serverTimestamp(),
            },
          );
          Get.snackbar('Success', 'Signed in as ${user?.displayName}');
        } else {
          await users.doc(user?.uid).set({
            'userId': user?.uid,
            'name': user?.displayName ?? 'Unknown User',
            'email': user?.email ?? '',
            'photoUrl': user?.photoURL ?? '',
            'balance': 0.0,
            'lastSignIn': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
          Get.snackbar('Success', 'Account created for ${user?.displayName}');
        }
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
      final user = auth.currentUser;

      if (user != null) {
        final CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        await users.doc(user.uid).update({'lastSignIn': null});
      }
      await googleSignIn.signOut();
      await auth.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', false);
      isLoggedIn.value = false;

      Get.snackbar('Success', 'Logged out successfully');
      Get.offNamed(MyAppRoutes.loginPage);
    } catch (e) {
      Get.snackbar("Logout Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> fetchBalanceFromFirestore() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists) {
          final balance = userDoc['balance'] ?? 0.0;
          Get.find<BalanceController>().setBalance(balance);
        } else {
          Get.find<BalanceController>()
              .setBalance(0.0); // Set balance to 0 if not found
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to fetch balance: $e');
      }
    }
  }
}
