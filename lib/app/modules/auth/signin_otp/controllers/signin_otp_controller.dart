import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:hive/hive.dart';
import 'package:usergrocery/app/modules/auth/signin/controllers/signin_controller.dart';
import 'package:usergrocery/app/widgets/progress.dart';

class SigninOtpController extends GetxController {
  static SigninOtpController get to => Get.find();

  RxBool timerChanged = true.obs;

  final storage = GetStorage();

  // String token;
  // String signature;
  // RxString code = ''.obs;
  // StreamSubscription _subscription;
  @override
  void onInit() async {
    super.onInit();
    // listenForCode();
    // SmsAutoFill().getAppSignature.then((signature) {
    //   signature = signature;
    // });
  }

  @override
  void onClose() {
    // _subscription.cancel();
    super.onClose();
  }

  // void listenForCode() {
  //   _subscription = SmsAutoFill().code.listen((code) {
  //     this.code.value = code;
  //   });
  //   SmsAutoFill().listenForCode;
  // }

  RxString verificationCode = ''.obs;

  void loginWithOtp(String mobile, String otp) async {
    ProgressBar().start();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode.value, smsCode: otp));
      if (userCredential?.user?.uid != null) {
        print(userCredential?.user?.uid);
        print('You are logged in and go to home');
        SigninController.to
            .afterGetttingFirebaseUid(uid: userCredential.user?.uid);
      }
    } catch (e) {
      ProgressBar().stop();

      Fluttertoast.showToast(msg: 'Sorry somwtning wen\'t wront');
    }
  }
}
