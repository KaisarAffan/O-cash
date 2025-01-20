import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BalanceController extends GetxController {
  var balance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBalance();
  }

  void fetchBalance() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists) {
          balance.value = (userDoc['balance'] as num).toDouble();
        } else {
          balance.value = 0.0; // Set balance to 0 if not found
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to fetch balance: $e');
      }
    }
  }

  Future<void> updateBalance(double newBalance) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'balance': newBalance});
        balance.value = newBalance;
      } catch (e) {
        Get.snackbar('Error', 'Failed to update balance: $e');
      }
    }
  }
}
