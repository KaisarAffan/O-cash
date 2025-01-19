import 'package:get/get.dart';
import 'package:ocash/pages/dashboard/dashboard.dart';
import 'package:ocash/pages/finance/finance.dart';
import 'package:ocash/pages/history/history.dart';
import 'package:ocash/pages/home/home.dart';
import 'package:ocash/pages/login/login.dart';
import 'package:ocash/pages/profile/profile.dart';
import 'package:ocash/pages/qris/qris.dart';
import 'package:ocash/pages/intro/intro.dart';
import 'package:ocash/pages/splashscreen/splashscreen.dart';
import 'package:ocash/pages/topup/topup.dart';
import 'package:ocash/pages/transfer/transfer.dart';
import 'package:ocash/routes/my_app_route.dart';

class MyAppPage {
  static final List<GetPage> pages = [
    //GetPage(name: name, page: page)
    GetPage(name: MyAppRoutes.splashScreen, page: () => Splashscreen()),
    GetPage(name: MyAppRoutes.introPage, page: () => IntroPage()),
    GetPage(name: MyAppRoutes.homePage, page: () => Home()),
    GetPage(name: MyAppRoutes.historyPage, page: () => History()),
    GetPage(name: MyAppRoutes.qrisPage, page: () => Qris()),
    GetPage(name: MyAppRoutes.financePage, page: () => Finance()),
    GetPage(name: MyAppRoutes.transferPage, page: () => TransferPage()),
    GetPage(name: MyAppRoutes.topUpPage, page: () => TopUpPage()),
    GetPage(name: MyAppRoutes.profilePage, page: () => Profile()),
    GetPage(name: MyAppRoutes.dashboard, page: () => Dashboard()),
    GetPage(name: MyAppRoutes.loginPage, page: () => Login()),
  ];
}
