import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');


  Future<double> getUserBalance(String userId) async {
    try {
      DocumentSnapshot userDoc = await users.doc(userId).get();
      return userDoc['balance'] ?? 0.0;
    } catch (e) {
      print('Error fetching balance: $e');
      return 0.0;
    }
  }

  Future<void> updateUserBalance(String userId, double amount) async {
    try {
      await users.doc(userId).update({'balance': FieldValue.increment(amount)});
    } catch (e) {
      print('Error updating balance: $e');
    }
  }
}
