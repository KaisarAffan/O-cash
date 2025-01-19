import 'package:flutter/material.dart';
import 'package:ocash/utils/color_pallete.dart';
import 'package:ocash/widgets/button/my_button.dart';
import 'package:ocash/widgets/my_text.dart';
import 'package:ocash/widgets/my_textfield.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.white, size: 40),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "Diana Dian",
                          fontsize: 18,
                          fontfamily: "MontserratBold",
                          color: white,
                          textAlign: TextAlign.left,
                        ),
                        MyText(
                          text: "Bank Jateng",
                          fontsize: 12,
                          fontfamily: "MontserratSemiBold",
                          color: white,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MyText(
              text: "Nominal",
              fontsize: 18,
              fontfamily: "MontserratBold",
              color: white,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            MyEditText(
              controller: CurrencyController().getController(),
              textInputType: TextInputType.number,
              hintText: "Masukkan nominal",
            ),
            SizedBox(height: 20),
            MyText(
              text: "Add message",
              fontsize: 18,
              fontfamily: "MontserratBold",
              color: white,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Stack(
              children: [
                MyEditText(
                  controller: null,
                  textInputType: TextInputType.number,
                  hintText: "Type your message here",
                ),
                Positioned(
                  right: 10,
                  top: 16,
                  bottom: 18,
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: MyButton(
                text: "Transfer",
                onPressed: () {},
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
