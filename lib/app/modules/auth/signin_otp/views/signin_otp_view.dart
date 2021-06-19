import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signin_otp_controller.dart';

import 'components/otp_body_view.dart';

class SigninOtpView extends GetView<SigninOtpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "OTP",
        ),
      ),
      body: OtpBodyView(),
    );
  }
}
