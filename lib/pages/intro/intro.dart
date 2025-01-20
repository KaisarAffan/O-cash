import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/pages/intro/controller.dart';
import 'package:ocash/routes/my_app_route.dart';
import 'package:ocash/widgets/button/my_button.dart';
import 'package:ocash/widgets/my_slider.dart';
import 'package:ocash/utils/color_pallete.dart';

class IntroPage extends StatelessWidget {
  IntroPage({super.key});

  final IntroController controller = Get.put(IntroController());

  final List<Map<String, String>> introData = [
    {
      "img": "assets/images/dompet3.png",
      "title": "Keamanan ekstra buat\nlindungin saldo mu",
      "description":
          "Bergabunglah dengan 3+ juta pengguna\nbertransaksi aman di Ocash",
    },
    {
      "img": "assets/images/dompet4.png",
      "title": "Nikmati fitur terbaik dari Ocash",
      "description": "Mulai sekarang, nikmati transaksi aman dan cepat!",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.updatePage,
              itemCount: introData.length,
              itemBuilder: (context, index) {
                final item = introData[index];
                return MySlider(
                  img: item["img"]!,
                  title: item["title"]!,
                  description: item["description"]!,
                );
              },
            ),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                introData.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4.0),
                  width: controller.currentPage.value == index ? 12.0 : 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: controller.currentPage.value == index
                        ? Colors.orange
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16, right: 16),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  width: 144,
                  child: MyButton(
                    text: controller.currentPage.value == introData.length - 1
                        ? "Start"
                        : "Next",
                    onPressed: () {
                      if (controller.currentPage.value < introData.length - 1) {
                        controller.pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                      if (controller.currentPage.value >=
                          introData.length - 1) {
                        Get.offNamed(MyAppRoutes.loginPage);
                      } else {
                        print("Navigasi ke halaman berikutnya!");
                      }
                    },
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.all(0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
