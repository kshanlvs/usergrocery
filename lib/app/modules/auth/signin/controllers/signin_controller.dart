import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:usergrocery/app/modules/auth/signin_otp/controllers/signin_otp_controller.dart';
import 'package:usergrocery/app/routes/app_pages.dart';
import 'package:usergrocery/app/widgets/progress.dart';

import '../../../../../Constants.dart';
// import 'package:faker/faker.dart';

class SigninController extends GetxController {
  static SigninController get to => Get.find();
  TextEditingController phoneTextField = TextEditingController();

  RxBool firstTimeCall = true.obs;

  findMobileNoForFirstTime() {
    if (firstTimeCall.value == true) {
      findMobileNumber();
      firstTimeCall.value = false;
    }
  }

  findMobileNumber() async {
    final SmsAutoFill _autoFill = SmsAutoFill();
    // _autoFill.listenForCode;
    var completePhoneNumber = await _autoFill.hint ?? '';

    if (completePhoneNumber.isNotEmpty) {
      var mob = completePhoneNumber.replaceAll('+91', '');
      this.phoneTextField.text = mob;
      /* this.phoneTextField.selection =
          TextSelection.fromPosition(TextPosition(offset: mob.length)); */
    }
  }
  //Mobile login @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  RxString verificationCode = ''.obs;

  getLoginOTP(String mobileNo) async {
    ProgressBar().start();
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91$mobileNo',
          verificationCompleted: (PhoneAuthCredential credential) async {
            ProgressBar().stop();

            UserCredential userCredential =
                await FirebaseAuth.instance.signInWithCredential(credential);
            if (userCredential.user?.uid == null) {
              print(userCredential.user?.uid);
              print('You are logged in and go to home');
              afterGetttingFirebaseUid(uid: userCredential.user?.uid);
            }
          },
          verificationFailed: (FirebaseAuthException e) {
            ProgressBar().stop();

            print(e.message);
          },
          codeSent: (verficationID, resendToken) {
            ProgressBar().stop();
            verificationCode.value = verficationID;

            SigninOtpController.to.verificationCode.value = verficationID;

            SigninOtpController.to.mobileNumber.value = mobileNo;

            Get.toNamed(Routes.SIGNIN_OTP, arguments: mobileNo);
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            ProgressBar().stop();
            verificationCode.value = verificationID;
          },
          timeout: Duration(seconds: 120));
    } catch (e) {
      ProgressBar().stop();
    }
  }

  //Google login @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  final googleSignIn = GoogleSignIn();

  Future googleLogin() async {
    ProgressBar().start();

    GoogleSignInAccount? user;

    try {
      user = (await googleSignIn.signIn())!;
      // user = await googleSignIn.signIn();
    } catch (e) {
      ProgressBar().stop();
      Fluttertoast.showToast(msg: 'Sorry somwtning wen\'t wront');
    }
    if (user == null) {
      ProgressBar().stop();

      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user?.uid != null) {
        print(userCredential.user?.uid);
        print('You are logged in and go to home');
        afterGetttingFirebaseUid(uid: userCredential.user?.uid);
      }
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  //Facebook login @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  //
  //
  //  bool isSignIn = false;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // FacebookLogin facebookLogin = FacebookLogin();

  Future<void> facebookLoginFunction() async {
    // final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    // switch (result.status) {
    //   case FacebookLoginStatus.cancelledByUser:
    //     break;
    //   case FacebookLoginStatus.error:
    //     break;
    //   case FacebookLoginStatus.loggedIn:
    //     try {
    //       await testFacebookLoginView(result);
    //     } catch (e) {
    //       print(e);
    //     }
    //     break;
    // }
  }
  testFacebookLoginView() {}

  // Future testFacebookLoginView(FacebookLoginResult result) async {
  //   final FacebookAccessToken accessToken = result.accessToken;
  //   AuthCredential credential =
  //       FacebookAuthProvider.credential(accessToken.token);
  //   UserCredential userCredential =
  //       await _auth.signInWithCredential(credential);

  //   if (userCredential?.user?.uid != null) {
  //     print(userCredential?.user?.uid);
  //     print('You are logged in and go to home');
  //     afterGetttingFirebaseUid(uid: userCredential?.user?.uid);
  //   }
  // }

  // Future<void> gooleSignout() async {
  //   // await _auth.signOut().then((onValue) {
  //   //   facebookLogin.logOut();
  //   // });
  // }

  final storage = GetStorage();

  // after getting firebase uid @@@@@@@@@@@@@@@@@@@
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(kftUsers);
  afterGetttingFirebaseUid({@required uid}) async {
    DocumentSnapshot<Object?> documentSnapshot = await usersCollection.doc(uid).get();
    if (documentSnapshot.exists) {
     
      String userType =  documentSnapshot['user_type'];
      // String userType = data['user_type']; //error

      ProgressBar().stop();

      // ignore: unnecessary_null_comparison
      if (userType != null && userType.contains(kfuser)) {
        ProgressBar().stop();
        storage.write(kfUid, uid);
        storage.write(kFirstTimeUser, false);

        Get.toNamed(Routes.HOME);
      } else {
        ProgressBar().stop();
        //

        Fluttertoast.showToast(msg: 'Sorry somwtning wen\'t wront');
      }
    } else {
      ProgressBar().stop();

      try {
        await usersCollection.doc(uid).set({
          kfuserType: kfuser,
        });

        storage.write(kfUid, uid);
        storage.write(kFirstTimeUser, false);

        Get.toNamed(Routes.HOME);
      } catch (e) {
        Fluttertoast.showToast(msg: 'Sorry somwtning wen\'t wront');
      }

      // Fluttertoast.showToast(msg: 'Sorry somwtning wen\'t wront');
      // usersCollection.doc(uid).set({'name': faker.person.name(),});
    }
  }
}
