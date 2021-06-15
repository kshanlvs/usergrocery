import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signin_otp_controller.dart';

class SigninOtpView extends GetView<SigninOtpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SigninOtpView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SigninOtpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
