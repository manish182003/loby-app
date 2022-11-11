import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class OTPDialog extends StatefulWidget {
  final TextEditingController otp;
  final Function() onVerify;
  const OTPDialog({Key? key, required this.onVerify, required this.otp}) : super(key: key);

  @override
  State<OTPDialog> createState() => _OTPDialogState();
}

class _OTPDialogState extends State<OTPDialog> {

  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    final textTheme  = Theme.of(context).textTheme;
    return Dialog(
      elevation: 0,
      backgroundColor: backgroundDarkJungleGreenColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: SizedBox(
        height: 26.h,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    autoDisposeControllers: false,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: false,
                    obscuringCharacter: '*',
                    animationType: AnimationType.scale,
                    validator: (v) {
                      if (v!.length < 6) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 45,
                      fieldWidth: 35,
                      activeColor: aquaGreenColor,
                      inactiveColor: textFieldColor,
                      selectedColor: aquaGreenColor,
                    ),
                    cursorColor: whiteColor,
                    animationDuration: const Duration(milliseconds: 100),
                    textStyle: textTheme.headline3?.copyWith(color: whiteColor),
                    // enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: widget.otp,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    }, onChanged: (String value) {  },


                  )),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.35,
                child: CustomButton(
                  color: purpleLightIndigoColor,
                  textColor: textWhiteColor,
                  name: "Verify OTP",
                  onTap: () {
                    if(_formKey.currentState!.validate()){
                      widget.onVerify();
                    }else{
                      errorController.add(ErrorAnimationType.shake);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
