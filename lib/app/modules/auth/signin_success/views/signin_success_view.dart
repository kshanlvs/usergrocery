import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signin_success_controller.dart';

class SigninSuccessView extends GetView<SigninSuccessController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SigninSuccessView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SigninSuccessView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
