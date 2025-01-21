import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/pages/transfer/controller.dart';
import 'package:ocash/services/firestore_service.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_button.dart';
import 'package:ocash/widgets/my_text.dart';
import 'package:ocash/widgets/my_textfield.dart';

class TransferPage extends StatelessWidget {
  TransferPage({super.key});

  final CurrencyController currencyController = CurrencyController();
  final TransferController transferController = Get.put(TransferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        title: const Text("Transfer"),
        centerTitle: true,
        backgroundColor: black,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: "Transfer to",
              fontsize: 16,
              fontfamily: "MontserratBold",
              color: white,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Obx(() {
              // Observe the list of users from the controller
              final users = transferController.users;

              if (users.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.orange),
                );
              }

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: transferController.selectedRecipient.value,
                  onChanged: (value) {
                    transferController.selectedRecipient.value = value!;
                  },
                  isExpanded: true,
                  underline: const SizedBox(),
                  dropdownColor: Colors.grey[800],
                  items: users.map((user) {
                    return DropdownMenuItem<String>(
                      value: user['email'], // Use email as the value
                      child: MyText(
                        text: "${user['name']} (${user['email']})",
                        fontsize: 16,
                        fontfamily: "MontserratSemiBold",
                        color: white,
                        textAlign: TextAlign.left,
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
            const SizedBox(height: 20),
            MyText(
              text: "Nominal",
              fontsize: 18,
              fontfamily: "MontserratBold",
              color: white,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            MyEditText(
              controller: currencyController.getController(),
              textInputType: TextInputType.number,
              hintText: "Masukkan nominal",
            ),
            const SizedBox(height: 20),
            MyText(
              text: "Add message",
              fontsize: 18,
              fontfamily: "MontserratBold",
              color: white,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            MyEditText(
              controller: transferController.messageController,
              textInputType: TextInputType.text,
              hintText: "Type your message here",
            ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: MyButton(
                text: "Transfer",
                onPressed: () async {
                  String currentUserEmail =
                      Get.find<FirestoreServices>().currentUserEmail;

                  String? recipientEmail =
                      transferController.selectedRecipient.value;

                  if (recipientEmail == currentUserEmail) {
                    Get.snackbar("Error", "You can't transfer to yourself!");
                    return;
                  }

                  if (recipientEmail == null) {
                    Get.snackbar("Error", "Please select a recipient!");
                    return;
                  }

                  double amount = double.tryParse(currencyController
                          .getController()
                          .text
                          .replaceAll("Rp.", "")
                          .trim()) ??
                      0.0;

                  if (amount <= 0) {
                    Get.snackbar("Error", "Please enter a valid amount!");
                    return;
                  }

                  String message = transferController.messageController.text;

                  bool success = await transferController.performTransfer(
                    recipientEmail: recipientEmail,
                    amount: amount,
                    message: message,
                  );

                  if (success) {
                    Get.snackbar("Success", "Transfer completed successfully!");
                    currencyController.getController().clear();
                    transferController.messageController.clear();
                  } else {
                    Get.snackbar("Error", "Transfer failed. Please try again.");
                  }
                },
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrencyController {
  final TextEditingController _controller = TextEditingController();

  CurrencyController() {
    _controller.text = "Rp.";
    _controller.addListener(() {
      if (!_controller.text.startsWith("Rp.")) {
        _controller.text = "Rp.";
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
    });
  }

  TextEditingController getController() => _controller;
}
