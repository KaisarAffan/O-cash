import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_icon_button.dart';
import 'package:ocash/widgets/my_historycard.dart';
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
      'backgroundColor': Colors.green,
    },
    {
      'title': 'Transfer to Mas Wahab',
      'status': 'Success',
      'time': '8:42 AM',
      'amount': 'Rp.94,500',
      'icon': Icons.arrow_upward,
      'backgroundColor': Colors.red,
    },
    {
      'title': 'Transfer to Kaisar',
      'status': 'Success',
      'time': '10:42 PM',
      'amount': 'Rp.1,000,000',
      'icon': Icons.arrow_upward,
      'backgroundColor': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: false,
        backgroundColor: black,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 16.0),
                ReusableIconButton(
                  icon: Icons.search,
                  text: 'Search',
                  buttonWidth: 50.0,
                  buttonHeight: 50.0,
                  iconSize: 24.0,
                  color: Colors.grey[800],
                  onPressed: () {},
                ),
                const SizedBox(width: 16.0),
                ReusableIconButton(
                  icon: Icons.sort,
                  text: 'Sort',
                  buttonWidth: 50.0,
                  buttonHeight: 50.0,
                  iconSize: 24.0,
                  color: Colors.grey[800],
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft, 
              child: MyText(
                text: "Sunday, 12 July 2025",
                fontsize: 16,
                fontfamily: "MontserratBold",
                color: Colors.white,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 12),
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
                    backgroundColor: data['backgroundColor'],
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
