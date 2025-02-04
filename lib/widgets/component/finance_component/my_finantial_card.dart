import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/my_text.dart';

class MyFinancialCard extends StatefulWidget {
  final String userId; // Pass the userId to this widget

  const MyFinancialCard({super.key, required this.userId});

  @override
  State<MyFinancialCard> createState() => _MyFinancialCardState();
}

class _MyFinancialCardState extends State<MyFinancialCard> {
  bool isBalanceHidden = false;

  void toggleBalanceVisibility() {
    setState(() {
      isBalanceHidden = !isBalanceHidden;
    });
  }

  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp.',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('income')
          .where('userId', isEqualTo: widget.userId) // Filter by userId
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> incomeSnapshot) {
        if (!incomeSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        double incomeSum = incomeSnapshot.data!.docs
            .fold(0.0, (sum, doc) => sum + (doc['amount'] as num).toDouble());

        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('outcome')
              .where('userId', isEqualTo: widget.userId) // Filter by userId
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> outcomeSnapshot) {
            if (!outcomeSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            double outcomeSum = outcomeSnapshot.data!.docs.fold(
                0.0, (sum, doc) => sum + (doc['amount'] as num).toDouble());

            double balance = incomeSum - outcomeSum;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: 'Financial records',
                          fontsize: 16,
                          fontfamily: 'MontserratBold',
                          color: white,
                          textAlign: TextAlign.start,
                        ),
                        MyText(
                          text: '1 Jan 2025 - 31 Jan 2025',
                          fontsize: 10,
                          fontfamily: 'MontserratMedi',
                          color: white,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: toggleBalanceVisibility,
                      child: Icon(
                        isBalanceHidden
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 30,
                        color: white,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCard('Income', incomeSum),
                    SizedBox(width: 24),
                    _buildCard('Outcome', outcomeSum),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: 'Balance',
                          fontsize: 14,
                          fontfamily: 'MontserratMedi',
                          color: white,
                          textAlign: TextAlign.start,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: isBalanceHidden
                                    ? '*******'
                                    : formatCurrency(balance),
                                style: TextStyle(
                                  color: white,
                                  fontFamily: 'MontserratBold',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCard(String title, double amount) {
    return Expanded(
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                text: title,
                fontsize: 14,
                fontfamily: 'MontserratMedi',
                color: white,
                textAlign: TextAlign.start,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          isBalanceHidden ? '*******' : formatCurrency(amount),
                      style: TextStyle(
                        color: white,
                        fontFamily: 'MontserratBold',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
