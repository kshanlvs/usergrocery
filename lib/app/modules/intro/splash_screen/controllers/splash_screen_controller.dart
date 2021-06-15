import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usergrocery/app/routes/app_pages.dart';

import '../../../../../Constants.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get to => Get.find();

  GetStorage storage = GetStorage();
  String uid = '';

  bool firstTimeUser = true;
  autoLogincall() async {
    firstTimeUser = await storage.read(kFirstTimeUser) ?? true;

    uid = await storage.read(kfUid) ?? '';

    Future.delayed(Duration(seconds: 2), () {
      if (firstTimeUser == true) {
        Get.toNamed(Routes.INTRO_SCREEN);
      } else if (uid != null && uid != '') {
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.SIGNIN);
      }
    });
  }
}
