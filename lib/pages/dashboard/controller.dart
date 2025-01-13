import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  void changeMenu(index) {
    selectedIndex.value = index;
  }
}
