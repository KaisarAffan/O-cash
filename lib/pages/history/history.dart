import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/component/history_component/my_history_card.dart';
import 'package:ocash/widgets/my_text.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final formattedHours = DateFormat('hh:mm a').format(dateTime);
    final formattedDay = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedHours;
  }

  String formatDaystamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final formattedDay = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDay;
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: const Center(child: Text('User not authenticated.')),
      );
    }

    return Scaffold(
      backgroundColor: black,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            MyText(
                text: 'Finance',
                fontsize: 32,
                fontfamily: 'MontserratBold',
                color: white,
                textAlign: TextAlign.center),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('income')
                    .where('userId', isEqualTo: userId)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final documents = snapshot.data?.docs ?? [];
                  if (documents.isEmpty) {
                    return const Center(child: Text('No history found.'));
                  }

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final doc =
                          documents[index].data() as Map<String, dynamic>;
                      final title = doc['title'] ?? 'Unknown Title';
                      final type = doc['type'] ?? 'Unknown Type';
                      final rawAmount =
                          doc['amount'] ?? 0; // Ambil nilai mentah dari amount
                      final amount = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp.',
                        decimalDigits: 0,
                      ).format(rawAmount); // Format nilai menjadi Rupiah

                      final timestamp = doc['timestamp'] as Timestamp?;

                      final formattedHours = timestamp != null
                          ? formatTimestamp(timestamp)
                          : 'Unknown Time';
                      final formattedDay = timestamp != null
                          ? formatDaystamp(timestamp)
                          : 'Unknown Time';

                      return MyHistoryCard(
                        title: title,
                        type: type,
                        timeHours: formattedHours,
                        timeDay: formattedDay,
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
