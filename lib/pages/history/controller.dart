import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class HistoryController extends GetxController {
  final RxList<dynamic> cachedData = [].obs;
  Stream<List<QuerySnapshot>>? _historyStream;
  @override
  void initState() {
    _historyStream = getHistoryStream();
  }

  Stream<List<QuerySnapshot>> getHistoryStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return const Stream.empty();

    return CombineLatestStream.list([
      FirebaseFirestore.instance
          .collection('income')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      FirebaseFirestore.instance
          .collection('outcome')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .snapshots(),
    ]);
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown Time';
    return DateFormat('hh:mm a').format(timestamp.toDate());
  }

  String formatDaystamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown Date';
    return DateFormat('dd MMM yyyy').format(timestamp.toDate());
  }

  bool hasDataChanged(List<QuerySnapshot> newData) {
    final newDocs = newData
        .expand((snapshot) => snapshot.docs)
        .map((doc) => doc.data())
        .toList();

    if (cachedData.isEmpty || cachedData.length != newDocs.length) {
      return true;
    }

    for (int i = 0; i < newDocs.length; i++) {
      if (cachedData[i].toString() != newDocs[i].toString()) {
        return true;
      }
    }

    return false;
  }
}
