import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FinancialRecordsCard extends StatefulWidget {
  @override
  _FinancialRecordsCardState createState() => _FinancialRecordsCardState();
}

class _FinancialRecordsCardState extends State<FinancialRecordsCard> {
  double totalIncome = 0;
  double totalOutcome = 0;
  double balance = 0;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    fetchFinancialData();
  }

  Future<void> fetchFinancialData() async {
    final firestore = FirebaseFirestore.instance;
    final startDate = DateTime(2025, 1, 1);
    final endDate = DateTime(2025, 1, 31, 23, 59, 59);

    // Fetch income data
    final incomeQuery = await firestore
        .collection('income') // Adjust collection name if needed
        .where('userId', isEqualTo: userId)
        .where('timestamp', isGreaterThanOrEqualTo: startDate)
        .where('timestamp', isLessThanOrEqualTo: endDate)
        .get();

    final outcomeQuery = await firestore
        .collection('outcome') // Adjust collection name if needed
        .where('userId', isEqualTo: userId)
        .where('timestamp', isGreaterThanOrEqualTo: startDate)
        .where('timestamp', isLessThanOrEqualTo: endDate)
        .get();

    double incomeSum = 0;
    double outcomeSum = 0;

    for (var doc in incomeQuery.docs) {
      incomeSum += doc['amount'];
    }

    for (var doc in outcomeQuery.docs) {
      outcomeSum += doc['amount'];
    }

    setState(() {
      totalIncome = incomeSum;
      totalOutcome = outcomeSum;
      balance = incomeSum - outcomeSum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Financial records',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Icon(Icons.visibility, color: Colors.white),
              ],
            ),
            SizedBox(height: 8),
            Text(
              '1 Jan 2025 - 31 Jan 2025',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFinancialItem(
                    'Income', 'Rp.${totalIncome.toStringAsFixed(0)}'),
                _buildFinancialItem(
                    'Outcome', '-Rp.${totalOutcome.toStringAsFixed(0)}'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Balance',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              'Rp.${balance.toStringAsFixed(0)}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
