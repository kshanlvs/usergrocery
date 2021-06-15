import 'package:get/get.dart';

import '../controllers/signin_otp_controller.dart';

class SigninOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninOtpController>(
      () => SigninOtpController(),
    );
  }
}
