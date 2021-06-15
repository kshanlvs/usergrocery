import 'package:get/get.dart';
import 'package:usergrocery/app/modules/auth/signin_otp/controllers/signin_otp_controller.dart';

import '../controllers/signin_controller.dart';

class SigninBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SigninController(), permanent: true);
    Get.put(SigninOtpController(), permanent: true);
  }
}
