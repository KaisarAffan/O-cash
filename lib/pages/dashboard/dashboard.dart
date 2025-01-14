import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocash/pages/dashboard/controller.dart';
import 'package:ocash/pages/finance/finance.dart';
import 'package:ocash/pages/history/history.dart';
import 'package:ocash/pages/home/home.dart';
import 'package:ocash/pages/profile/profile.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController =
        Get.put(DashboardController());

    final List<Widget> menus = [
      Home(),
      History(),
      Finance(),
      Profile(),
    ];

    return Obx(() {
      return Scaffold(
        body: menus[dashboardController.selectedIndex.value],
        bottomNavigationBar: _navBar(dashboardController),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 64,
          width: 64,
          child: FloatingActionButton(
            backgroundColor: Color(0xffFF9500),
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.qr_code_rounded,
              color: Color(0xffFFFFFF),
              size: 30,
            ),
          ),
        ),
      );
    });
  }
}

Widget _navBar(DashboardController dashboardController) {
  return Container(
      height: 76,
      decoration: BoxDecoration(
          color: const Color(0xff222831),
          borderRadius: BorderRadius.circular(8),
          border: Border(
            top: BorderSide(
              color: Color(0xffFF9500),
              width: 1,
            ),
          )),
      child: ClipRRect(
        child: Obx(
          () => Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: BottomNavigationBar(
                showSelectedLabels: true,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color(0xff2F2F2F),
                selectedItemColor: const Color(0xff34C759),
                selectedLabelStyle: TextStyle(fontSize: 12),
                unselectedItemColor: const Color(0xffFFFFFF),
                currentIndex: dashboardController.selectedIndex.value,
                onTap: (index) => dashboardController.changeMenu(index),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_filled,
                      size: 28,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.receipt_long_outlined,
                      size: 28,
                    ),
                    label: "History",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.credit_card,
                      size: 28,
                    ),
                    label: "Finance",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      size: 28,
                    ),
                    label: "Profile",
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
}
