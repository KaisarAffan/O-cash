import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ocash/routes/my_app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreServices extends GetxController {
  var currentUser = Rxn<User>();
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();

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
  String get currentUserId => currentUser.value?.uid ?? '';
  String get currentUserEmail => currentUser.value?.email ?? '';

  void handleAuthError(FirebaseAuthException e) {
    String errorMessage;

    switch (e.code) {
      case 'account-exists-with-different-credential':
        errorMessage = 'Account exists with a different credential.';
        break;
      case 'invalid-credential':
        errorMessage = 'Invalid credentials provided.';
        break;
      case 'user-disabled':
        errorMessage = 'This user account has been disabled.';
        break;
      default:
        errorMessage = 'Authentication failed: ${e.message}';
    }

    Get.snackbar('Error', errorMessage);
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> loginWithGoogle() async {
    isLoading.value = true;

    try {
      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

      if (googleAccount == null) {
        Get.snackbar("Sign-In Cancelled", "User cancelled sign-in.");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        Get.snackbar("Error", "Failed to retrieve user information.");
        return;
      }

      // Get FCM token
      final token = await messaging.getToken();
      print('FCM Token $token');

      // Update SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      isLoggedIn.value = true;

      // Firestore User Update/Creation
      final usersCollection = firestore.collection('users');
      final DocumentReference userDoc = usersCollection.doc(user.uid);

      final DocumentSnapshot userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        // Update existing user
        await userDoc.update({
          'lastSignIn': FieldValue.serverTimestamp(),
          'fcm_token': token,
        });
        Get.snackbar('Welcome Back', 'Signed in as ${user.displayName}');
      } else {
        // Create a new user
        await userDoc.set({
          'userId': user.uid,
          'name': user.displayName ?? 'Unknown User',
          'email': user.email ?? '',
          'photoUrl': user.photoURL ?? '',
          'balance': 0.0,
          'lastSignIn': FieldValue.serverTimestamp(),
          'fcm_token': token,
        });
        Get.snackbar('Success', 'Account created for ${user.displayName}');
      }

      Get.offNamed(MyAppRoutes.dashboard);
    } on FirebaseAuthException catch (e) {
      handleAuthError(e);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;

    try {
      final user = auth.currentUser;

      if (user != null) {
        // Update Firestore with logout timestamp
        final usersCollection = firestore.collection('users');
        await usersCollection.doc(user.uid).update({'lastSignIn': null});
      }

      await googleSignIn.signOut();
      await auth.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', false);
      isLoggedIn.value = false;

      Get.snackbar('Success', 'Logged out successfully');
      Get.offNamed(MyAppRoutes.loginPage);
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              'high_importance_channel', 'High Importance Notifications',
              channelDescription:
                  'This channel is used for importance notifications!',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher'),
        ),
        payload: message.data.toString(),
      );
    }
  }
}
