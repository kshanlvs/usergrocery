import 'package:get/get.dart';

import '../controllers/signin_success_controller.dart';

class SigninSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninSuccessController>(
      () => SigninSuccessController(),
    );
  }
}
