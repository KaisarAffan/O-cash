import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/component/history_component/my_history_card.dart';
import 'package:ocash/widgets/component/history_component/my_historyactivity_button.dart';
import 'package:ocash/widgets/my_text.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final List<Map<String, dynamic>> dummyData = [
    {
      'title': 'Top Up O’cash',
      'status': 'Success',
      'time': '10:01 AM',
      'amount': 'Rp.50,000',
      'icon': Icons.add,
    },
    {
      'title': 'Transfer to Mas Wahab',
      'status': 'Success',
      'time': '8:42 AM',
      'amount': 'Rp.94,500',
      'icon': Icons.arrow_upward,
    },
    {
      'title': 'Transfer to Kaisar',
      'status': 'Success',
      'time': '10:42 PM',
      'amount': 'Rp.1,000,000',
      'icon': Icons.arrow_upward,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(
                  text: "History",
                  fontsize: 32,
                  fontfamily: "MontserratBold",
                  color: white,
                  textAlign: TextAlign.center),
            ),
            MyHistoryactivityButton(),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  text: "Sunday, 12 July 2025",
                  fontsize: 16,
                  fontfamily: "MontserratBold",
                  color: Colors.white,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: dummyData.length,
                itemBuilder: (context, index) {
                  final data = dummyData[index];
                  return MyHistoryCard(
                    title: data['title'],
                    status: data['status'],
                    time: data['time'],
                    amount: data['amount'],
                    icon: data['icon'],
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
