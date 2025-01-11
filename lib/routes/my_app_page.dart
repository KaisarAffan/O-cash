import 'package:get/get.dart';
import 'package:ocash/pages/profile/profile.dart';
import 'package:ocash/routes/my_app_route.dart';

class MyAppPage {
  static final List<GetPage> pages = [
    //GetPage(name: name, page: page)
    GetPage(name: MyAppRoutes.profilePage, page: () => Profile())
  ];
}
