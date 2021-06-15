import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SvgPicture.asset('images/hairSalon/bh_logo.svg',
            //     height: 250, width: 250, color: Colors.black.withOpacity(0.7)),
            SizedBox(
              height: 20,
            ),
            Text(
              'HD Mackup Studio',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
