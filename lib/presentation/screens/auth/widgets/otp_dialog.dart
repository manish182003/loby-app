import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/helpers.dart';

class OTPDialog extends StatefulWidget {
  final TextEditingController otp;
  final Function() onVerify;
  const OTPDialog({Key? key, required this.onVerify, required this.otp})
      : super(key: key);

  @override
  State<OTPDialog> createState() => _OTPDialogState();
}

class _OTPDialogState extends State<OTPDialog> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login_bg_img.jpeg"),
                opacity: 0.5,
                fit: BoxFit.fill),
          ),
        ),
        Builder(
          builder: (BuildContext  context) {
            return Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 0,
                  right: 0,

              child: SingleChildScrollView(
                child: Container(
                  height: 60.h,
                  width: MediaQuery.of(context).size.width,
                  // child: Text("hellooo", style: TextStyle(color: Colors.amber , fontSize: 60),),
                  decoration: const BoxDecoration(
                      color: backgroundColor,
                      // border: Border(top: BorderSide(color: Colors.white)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  // child: Text("Login", style: textTheme.headline2?.copyWith(color: textWhiteColor)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28, right: 28, top: 40),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Login",
                            style:
                                textTheme.headline1?.copyWith(color: textWhiteColor)),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Enter 4 Digit OTP Number",
                                  style: textTheme.headline2
                                      ?.copyWith(color: whiteColor, fontSize: 18.sp)),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                  "Please Confirm Your Country and Enter Your Mobile Number",
                                  style: textTheme.headline5?.copyWith(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w100)),
                              SizedBox(
                                height: 4.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: PinCodeTextField(
                                  appContext: context,
                                  autoDisposeControllers: false,
                                  pastedTextStyle: TextStyle(
                                    color: Colors.green.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  length: 4,
                                  obscureText: false,
                                  obscuringCharacter: '*',
                                  animationType: AnimationType.scale,
                                  validator: (v) {
                                    if (v!.length < 4) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 65,
                                    fieldWidth: 55,
                                    activeColor: aquaGreenColor,
                                    inactiveColor: shipGreyColor,
                                    selectedColor: aquaGreenColor,
                                  ),
                                  cursorColor: whiteColor,
                                  animationDuration:
                                      const Duration(milliseconds: 100),
                                  textStyle: textTheme.headline3
                                      ?.copyWith(color: whiteColor),
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
                                  },
                                  onChanged: (String value) {},
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Didn't Received ?",
                                        style: textTheme.headline4?.copyWith(
                                            color: textWhiteColor,
                                            fontWeight: FontWeight.w300)),
                                    InkWell(
                                      onTap: () async {
                                        await Helpers.loader();
                                        await Future.delayed(Duration(milliseconds: 1000));
                                        await authController.login(
                                            mobile:
                                                authController.mobilecontroller.text.replaceAll(' ', ''));
                                                await Helpers.hideLoader();
                                      },
                                      child: Container(
                                          height: 35,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              color: aquaGreenColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text("Resend",
                                                style: textTheme.headline4?.copyWith(
                                                    color: textWhiteColor,
                                                    fontWeight: FontWeight.w300)),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              CustomButton(
                                  height: 8.h,
                                  fontSize: 15.sp,
                                  name: "Login",
                                  color: aquaGreenColor,
                            
                                  // left: 0.w,
                                  // right: 0.w,
                                  bottom: 3.h,
                                  top: 2.h,
                                  onTap: () async {
                                    widget.onVerify();
                                    //           if(_formKey.currentState!.validate()){
                                    //   widget.onVerify();
                                    // }else{
                                    //   errorController.add(ErrorAnimationType.shake);
                                    // }
                                    // _otpDialog(context);
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        )
      ]),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final textTheme  = Theme.of(context).textTheme;
  //   return Dialog(
  //     elevation: 0,
  //     backgroundColor: backgroundDarkJungleGreenColor,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
  //     child: SizedBox(
  //       height: 26.h,
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           children: [
  //             Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 30),
  //                 child: PinCodeTextField(
  //                   appContext: context,
  //                   autoDisposeControllers: false,
  //                   pastedTextStyle: TextStyle(
  //                     color: Colors.green.shade600,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   length: 6,
  //                   obscureText: false,
  //                   obscuringCharacter: '*',
  //                   animationType: AnimationType.scale,
  //                   validator: (v) {
  //                     if (v!.length < 6) {
  //                       return "";
  //                     } else {
  //                       return null;
  //                     }
  //                   },
  //                   pinTheme: PinTheme(
  //                     shape: PinCodeFieldShape.box,
  //                     borderRadius: BorderRadius.circular(5),
  //                     fieldHeight: 45,
  //                     fieldWidth: 35,
  //                     activeColor: aquaGreenColor,
  //                     inactiveColor: textFieldColor,
  //                     selectedColor: aquaGreenColor,
  //                   ),
  //                   cursorColor: whiteColor,
  //                   animationDuration: const Duration(milliseconds: 100),
  //                   textStyle: textTheme.headline3?.copyWith(color: whiteColor),
  //                   // enableActiveFill: true,
  //                   errorAnimationController: errorController,
  //                   controller: widget.otp,
  //                   keyboardType: TextInputType.number,
  //                   boxShadows: const [
  //                     BoxShadow(
  //                       offset: Offset(0, 1),
  //                       color: Colors.black12,
  //                       blurRadius: 10,
  //                     )
  //                   ],
  //                   onCompleted: (v) {
  //                     FocusManager.instance.primaryFocus?.unfocus();
  //                   },
  //                   beforeTextPaste: (text) {
  //                     print("Allowing to paste $text");
  //                     //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
  //                     //but you can show anything you want here, like your pop up saying wrong paste format or etc
  //                     return true;
  //                   }, onChanged: (String value) {  },

  //                 )),
  //             SizedBox(
  //               width: MediaQuery
  //                   .of(context)
  //                   .size
  //                   .width * 0.35,
  //               child: CustomButton(
  //                 color: purpleLightIndigoColor,
  //                 textColor: textWhiteColor,
  //                 name: "Verify OTP",
  //                 onTap: () {
  //                   if(_formKey.currentState!.validate()){
  //                     widget.onVerify();
  //                   }else{
  //                     errorController.add(ErrorAnimationType.shake);
  //                   }
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
