import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import '../../../../../Constants.dart';

class IntroScreenController extends GetxController {
  static IntroScreenController get to => Get.find();

  GetStorage storage = GetStorage();
  String uid = '';

  bool firstTimeUser = true;
  checkForLogin() async {
    uid = await storage.read(kfUid) ?? '';

    if (uid != null && uid != '') {
      Get.toNamed(Routes.HOME);
    } else {
      Get.toNamed(Routes.SIGNIN);
    }
  }
}
