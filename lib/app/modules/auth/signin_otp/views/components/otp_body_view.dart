import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'otp_form_view.dart';

//import 'package:sms_autofill/sms_autofill.dart';
class OtpBodyView extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.04),
              Text(
                " OTP Verification",
                // style: headingStyle,
              ),
              Text("We have sent your code "),
              // SizedBox(height: getScreenHeight(50)),
              OtpFormView(),
              // OtpFormView(),
              // OtpFormView(),
              // SizedBox(height: getScreenHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}
