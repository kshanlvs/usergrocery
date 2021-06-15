import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:usergrocery/app/modules/auth/signin/controllers/signin_controller.dart';
import 'package:usergrocery/app/modules/auth/signin/views/components/signin_form_view.dart';

class SigninBodyView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Enter Mobile Number",
            // style: headingStyle,
          ),
          Text(
            "Enter your 10 digit mobile number,\n whether you are a new or an existing user",
            style: TextStyle(color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          SigninFormView(),

          CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              "Or",
              style: TextStyle(fontSize: 15),
            ),
          ),

          // Divider(),
          SignInButton(
            Buttons.Google,
            // mini: false,
            onPressed: () {
              SigninController.to.googleLogin();
            },
          ),
          // SignInButton(
          //   Buttons.Facebook,
          //   // mini: false,
          //   onPressed: () {
          //     // SigninController.to.facebookLoginFunction();
          //   },
          // )

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "Don’t have an account? ",
          //       style: TextStyle(fontSize: getScreenWidth(15)),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         Get.toNamed(Routes.SIGNUP);
          //       },
          //       child: Text(
          //         "Sign Up",
          //         style: TextStyle(
          //             fontSize: getScreenWidth(16),
          //             color: kPrimaryDarkColor),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
