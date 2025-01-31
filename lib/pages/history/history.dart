import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/component/history_component/my_history_card.dart';
import 'package:ocash/widgets/my_text.dart';
import 'package:rxdart/rxdart.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final List<Map<String, dynamic>> _cachedData = []; // Cache previous data
  Stream<List<QuerySnapshot>>? _historyStream;

  @override
  void initState() {
    super.initState();
    _historyStream = getHistoryStream();
  }

  /// Get the Firestore stream and merge income/outcome collections
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

  /// Format timestamp to `hh:mm a`
  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown Time';
    return DateFormat('hh:mm a').format(timestamp.toDate());
  }

  /// Format timestamp to `dd MMM yyyy`
  String formatDaystamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown Date';
    return DateFormat('dd MMM yyyy').format(timestamp.toDate());
  }

  /// Compare new data with cached data
  bool _hasDataChanged(List<QuerySnapshot> newData) {
    final newDocs = newData
        .expand((snapshot) => snapshot.docs)
        .map((doc) => doc.data())
        .toList();

    if (_cachedData.isEmpty || _cachedData.length != newDocs.length) {
      return true; // Data size changed, UI should update
    }

    for (int i = 0; i < newDocs.length; i++) {
      if (_cachedData[i].toString() != newDocs[i].toString()) {
        return true; // Content changed, UI should update
      }
    }

    return false; // No changes, UI should not update
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: const Center(
          child: Text(
            'User not authenticated.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            MyText(
              text: 'History',
              fontsize: 32,
              fontfamily: 'MontserratBold',
              color: white,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: StreamBuilder<List<QuerySnapshot>>(
                stream: _historyStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading data: ${snapshot.error}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }

                  final incomeDocs = snapshot.data?[0].docs ?? [];
                  final outcomeDocs = snapshot.data?[1].docs ?? [];
                  final allDocs = [...incomeDocs, ...outcomeDocs];

                  // Check if no data is found
                  if (allDocs.isEmpty) {
                    return const Center(
                      child: Text(
                        'Data not found.',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  }

                  // Prevent unnecessary rebuilds by checking data changes
                  if (!_hasDataChanged(snapshot.data!)) {
                    return const SizedBox.shrink(); // Do not rebuild UI
                  }

                  // Cache new data
                  _cachedData.clear();
                  _cachedData.addAll(
                      allDocs.map((doc) => doc.data() as Map<String, dynamic>));

                  // Sort documents by timestamp
                  allDocs.sort((a, b) {
                    final Timestamp aTimestamp =
                        a['timestamp'] ?? Timestamp.now();
                    final Timestamp bTimestamp =
                        b['timestamp'] ?? Timestamp.now();
                    return bTimestamp.compareTo(aTimestamp);
                  });

                  return ListView.builder(
                    itemCount: allDocs.length,
                    itemBuilder: (context, index) {
                      final doc = allDocs[index].data() as Map<String, dynamic>;
                      final String title = doc['title'] ?? 'Unknown Title';
                      final String type = doc['type'] ?? 'Unknown Type';
                      final double amountValue =
                          (doc['amount'] ?? 0).toDouble();
                      final String amount = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp.',
                        decimalDigits: 0,
                      ).format(amountValue);
                      final Timestamp? timestamp =
                          doc['timestamp'] as Timestamp?;

                      return MyHistoryCard(
                        title: title,
                        type: type,
                        timeHours: formatTimestamp(timestamp),
                        timeDay: formatDaystamp(timestamp),
                        amount: amount,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
