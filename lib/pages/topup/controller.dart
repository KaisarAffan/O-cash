import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ocash/pages/home/controller.dart';

class TopUpController extends GetxController {
  final TextEditingController currencyController = TextEditingController();
  final BalanceController balanceController = Get.find<BalanceController>();

  TopUpController() {
    currencyController.text = "Rp.";
    currencyController.addListener(() {
      if (!currencyController.text.startsWith("Rp.")) {
        currencyController.text = "Rp.";
        currencyController.selection = TextSelection.fromPosition(
          TextPosition(offset: currencyController.text.length),
        );
      }
    });
  }

  void handleTopUp(double amount) {
    final currentBalance = balanceController.balance.value;
    final newBalance = currentBalance + amount;
    balanceController.updateBalance(newBalance);
    Get.snackbar("Success", "Your balance has been updated!");
  }

  Future<void> topUp(double amount) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(userId);
        final userDoc = await userDocRef.get();

        if (userDoc.exists) {
          final currentBalance = (userDoc['balance'] as num).toDouble();
          final newBalance = currentBalance + amount;

          // Update the balance in the user table
          await userDocRef.update({'balance': newBalance});
          balanceController.balance.value = newBalance;

          // Add a record in the income table
          final incomeData = {
            'userId': userId,
            'amount': amount,
            'timestamp': FieldValue.serverTimestamp(),
            'type': 'Top-Up',
          };

          await FirebaseFirestore.instance
              .collection('income')
              .add(incomeData)
              .then((docRef) {
            print("Income record added with ID: ${docRef.id}");
          });

          Get.snackbar(
            'Success',
            'Top-up of Rp.${amount.toStringAsFixed(2)} completed!',
          );
        } else {
          print("User document does not exist.");
          Get.snackbar("Error", "User not found in the database.");
        }
      } catch (e) {
        print("Error during top-up: $e");
        Get.snackbar('Error', 'Failed to process top-up: $e');
      }
    } else {
      print("User ID is null.");
      Get.snackbar("Error", "User not authenticated.");
    }
  }
}
