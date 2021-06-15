import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:usergrocery/app/modules/auth/signin/controllers/signin_controller.dart';

// ignore: must_be_immutable
class SigninFormView extends GetView<SigninController> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: _fbKey,
      child: Column(
        children: [
          Container(
            height: 80,
            child: FormBuilderTextField(
              controller: controller.phoneTextField,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              name: 'mobile',
              maxLength: 10,
              onChanged: (code) {
                if (code!.length == 10) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              onTap: () {
                controller.findMobileNoForFirstTime();
              },

              decoration: InputDecoration(
                  counterText: '',
                  hintText: "Mobile No",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(
                    Icons.phone_android,
                    color: Colors.blue,
                  ),
                  prefixText: '+91 ',
                  prefixStyle: TextStyle(fontSize: 16)),
              // validators: [
              //   FormBuilderValidators.required(),
              //   FormBuilderValidators.minLength(10),
              // ],
            ),
          ),
          RaisedButton(
            child: Text('Send OTP'),
            onPressed: () {
              if (_fbKey.currentState!.saveAndValidate()) {
                SigninController.to
                    .getLoginOTP(controller.phoneTextField.text!.trim());
              }
            },
          ),
        ],
      ),
    );
  }
}
