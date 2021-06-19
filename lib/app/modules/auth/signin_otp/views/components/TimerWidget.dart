import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usergrocery/app/modules/auth/signin_otp/controllers/signin_otp_controller.dart';

class TimerWidget extends GetView<SigninOtpController> {
  // const TimerWidget({
  //   // Key key,
  //   // @required this.mobile,
  // }) : super(key: key);

  // final String mobile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TweenAnimationBuilder(
          tween: Tween(begin: 30, end: 00.0),
          duration: Duration(seconds: 30),
          builder: (_, value, child) {
            // if (value.toInt() == 0.0) {
            //   return GestureDetector(
            //     onTap: () {
            //       SigninOtpController.to.resendOtp(mobile.trim());
            //     },
            //     child: Text(
            //       "Resend OTP",
            //       style: TextStyle(),
            //     ),
            //   );
            // }
            return Text(
              "Wait for OTP 00:${value.toString()}",
            );
          },
        ),
      ],
    );
  }
}
