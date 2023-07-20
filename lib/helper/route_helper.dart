import 'package:efood_table_booking/helper/responsive_helper.dart';
import 'package:efood_table_booking/view/base/animated_dialog.dart';
import 'package:efood_table_booking/view/screens/home/home_screen.dart';
import 'package:efood_table_booking/view/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/order/widget/test_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String testscreen = '/testscreen';
  static getInitialRoute() => '$initial';
  static getSplashRoute() => '$splash';
  static getHomeRoute(String name) => '$home?name=$name';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => SplashScreen()),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: testscreen, page: () => TestScreen()),
    GetPage(
      name: home, page: () => HomeScreen(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];

  static void openDialog(BuildContext context, Widget child, {bool isDismissible = true}) {
    !ResponsiveHelper.isTab(context) ?
    Get.bottomSheet(isDismissible: isDismissible, child, backgroundColor: Colors.transparent,
      enterBottomSheetDuration:  Duration(milliseconds: 100),
      isScrollControlled: true,) :
    // Get.dialog(
    //   useSafeArea: true,
    //
    //   transitionDuration: Duration(milliseconds: 300),
    //   Dialog(backgroundColor: Colors.transparent, child:  child,),
    // );
    showAnimatedDialog(
      context: context,
      duration: Duration(milliseconds: 200),
      barrierDismissible: isDismissible,

      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child:  child,
        );
      },
      animationType: DialogTransitionType.slideFromBottomFade,
    );
  }

}