import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  var currentPage = 0.obs;
  PageController pageController = PageController();

  void updatePage(int page) {
    currentPage.value = page;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
