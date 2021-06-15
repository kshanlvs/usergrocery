import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/intro_screen_controller.dart';

class IntroScreenView extends GetView<IntroScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IntroScreenView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'IntroScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
