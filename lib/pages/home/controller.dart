import 'package:get/get.dart';
import 'package:ocash/services/firestore_service.dart';

class BalanceController extends GetxController {
  var balance = 0.0.obs;

  void setBalance(double newBalance) {
    balance.value = newBalance;
  }

  Future<void> fetchBalance(String userId) async {
    final FirestoreService firestoreService = FirestoreService();
    final fetchedBalance = await firestoreService.getUserBalance(userId);
    balance.value = fetchedBalance;
  }
}
