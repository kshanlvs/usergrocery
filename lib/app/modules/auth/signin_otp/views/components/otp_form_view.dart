import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:usergrocery/app/modules/auth/signin_otp/controllers/signin_otp_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';

import 'TimerWidget.dart';

// ignore: must_be_immutable
class OtpFormView extends GetView<SigninOtpController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      child: Container(
        width: Get.width * .70,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            // otpFormField(),
            PinFieldAutoFill(
              decoration: UnderlineDecoration(
                // bgColorBuilder: FixedColorBuilder(Colors.grey.shade200),
                // gapSpace: 3,
                textStyle: TextStyle(fontSize: 20, color: Colors.black),
                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              ),
              currentCode: SigninOtpController.to.code.value,
              onCodeSubmitted: (code) {
                // tempOtp = code;
                SigninOtpController?.to?.code?.value = code;
              },
              onCodeChanged: (code) {
                if (code!.length == 6) {
                  SigninOtpController?.to?.code?.value = code;
                  SigninOtpController.to.loginWithOtp(
                      controller.mobileNumber.value,
                      SigninOtpController?.to?.code?.value ?? '');
                  FocusScope.of(context).requestFocus(FocusNode());
                  print(code);
                }
              },
            ),
            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offAndToNamed(Routes.SIGNIN);
                  },
                  child: Text(
                    "Change Number",
                    style: TextStyle(),
                  ),
                ),
                Obx(() {
                  if (SigninOtpController?.to?.timerChanged?.value != null) {
                    return TimerWidget();
                  } else {
                    return TimerWidget();
                  }
                })
              ],
            ),
            SizedBox(height: Get.height * 0.05),
            RaisedButton(
              child: Text('Continue'),
              onPressed: () {
                if (_fbKey.currentState!.saveAndValidate()) {
                  // String tempOtp = SigninOtpController?.to?.code?.value;
                  SigninOtpController.to.loginWithOtp(
                      controller.mobileNumber.value,
                      SigninOtpController?.to?.code.value ?? '');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
