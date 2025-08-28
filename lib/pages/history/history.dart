import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:ocash/pages/history/controller.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/component/history_component/my_history_card.dart';
import 'package:ocash/widgets/my_text.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final HistoryController controller = HistoryController();
  @override
  Widget build(BuildContext context) {
    controller.initState();
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
              child: Obx(
                () => StreamBuilder<List<QuerySnapshot>>(
                  stream: controller.getHistoryStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error loading data: ${snapshot.error}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      );
                    }

                    final incomeDocs = snapshot.data?[0].docs ?? [];
                    final outcomeDocs = snapshot.data?[1].docs ?? [];
                    final allDocs = [...incomeDocs, ...outcomeDocs];

                    if (allDocs.isEmpty) {
                      return const Center(
                        child: Text(
                          'Data not found.',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      );
                    }

                    if (!controller.hasDataChanged(snapshot.data!)) {
                      return const SizedBox.shrink();
                    }

                    controller.cachedData.clear();

                    controller.cachedData.addAll(allDocs
                        .map((doc) => doc.data() as Map<String, dynamic>));

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
                        final doc =
                            allDocs[index].data() as Map<String, dynamic>;
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
                          timeHours: controller.formatTimestamp(timestamp),
                          timeDay: controller.formatDaystamp(timestamp),
                          amount: amount,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
