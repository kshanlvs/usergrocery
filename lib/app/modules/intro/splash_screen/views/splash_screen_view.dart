import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:usergrocery/theme/color_theme.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("bag2door",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
          Text("India's Fastest Grocery Delivery App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),


       
          Padding(
            padding: const EdgeInsets.only(left:50,right:50),
            child: Divider(color: Colors.white,),
          ),
          Text(" MADE IN INDIA",style: TextStyle(fontWeight: FontWeight.bold,),)
        ],
      ),)
      
      //  Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       // SvgPicture.asset('images/hairSalon/bh_logo.svg',
      //       //     height: 250, width: 250, color: Colors.black.withOpacity(0.7)),
      //       SizedBox(
      //         height: 20,
      //       ),
      //       Text(
      //         'HD Mackup Studio',
      //         style: TextStyle(fontSize: 30),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
