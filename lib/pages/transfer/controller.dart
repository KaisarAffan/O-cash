import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/services/googlesignin_service.dart';

class TransferController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var users = <Map<String, dynamic>>[].obs;
  var selectedRecipient = Rxn<String>();
  final messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      final querySnapshot = await _firestore.collection('users').get();
      users.value = querySnapshot.docs
          .map((doc) => {
                'email': doc['email'],
                'name': doc['name'],
              })
          .toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch users: $e");
    }
  }

  Future<bool> performTransfer({
    required String recipientEmail,
    required double amount,
    required String message,
  }) async {
    // Replace these with the current authenticated user's ID and email
    String currentUserId = Get.find<GoogleSignInController>().currentUserId;
    String currentUserEmail =
        Get.find<GoogleSignInController>().currentUserEmail;

    try {
      // Get recipient data
      QuerySnapshot recipientSnapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: recipientEmail)
          .get();

      if (recipientSnapshot.docs.isEmpty) {
        Get.snackbar("Error", "Recipient not found.");
        return false;
      }

      var recipientData =
          recipientSnapshot.docs.first.data() as Map<String, dynamic>;
      String recipientId = recipientSnapshot.docs.first.id;
      double recipientBalance = (recipientData["balance"] ?? 0).toDouble();

      // Get sender data
      DocumentSnapshot senderSnapshot =
          await _firestore.collection("users").doc(currentUserId).get();
      var senderData = senderSnapshot.data() as Map<String, dynamic>;
      double senderBalance = (senderData["balance"] ?? 0).toDouble();

      // Check balance
      if (senderBalance < amount) {
        Get.snackbar("Error", "Insufficient balance.");
        return false;
      }

      // Update balances and save history in a transaction
      await _firestore.runTransaction((transaction) async {
        // Update sender balance
        transaction.update(
          _firestore.collection("users").doc(currentUserId),
          {"balance": senderBalance - amount},
        );

        // Update recipient balance
        transaction.update(
          _firestore.collection("users").doc(recipientId),
          {"balance": recipientBalance + amount},
        );

        // Save transfer history
        var timestamp = FieldValue.serverTimestamp();

        // Outcome (sender)
        transaction.set(
          _firestore.collection("outcome").doc(),
          {
            "userId": currentUserId,
            "amount": amount,
            "recipient": recipientEmail,
            "message": message,
            "timestamp": timestamp,
          },
        );

        // Income (recipient)
        transaction.set(
          _firestore.collection("income").doc(),
          {
            "userId": recipientId,
            "amount": amount,
            "sender": currentUserEmail,
            "message": message,
            "timestamp": timestamp,
          },
        );
      });

      Get.snackbar("Success", "Transfer completed successfully!");
      return true;
    } catch (e) {
      Get.snackbar("Error", "Transfer failed: $e");
      print("Transfer failed: $e");
      return false;
    }
  }
}
