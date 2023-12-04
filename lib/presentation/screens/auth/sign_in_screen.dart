import 'dart:async';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/screens/auth/widgets/create_account.dart';
import 'package:loby/presentation/screens/auth/widgets/create_profile_bottom_sheet.dart';
import 'package:loby/presentation/screens/auth/widgets/login.dart';
import 'package:loby/presentation/screens/auth/widgets/otp_dialog.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_bottom_sheet.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/helpers.dart';
import '../../widgets/text_fields/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthController authController = Get.find<AuthController>();
  ProfileController profileController = Get.find<ProfileController>();
  // TextEditingController mobile = TextEditingController();
  TextEditingController otp = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  String formatText(String text) {
    // Remove any non-numeric characters from the input
    String formattedText = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Apply the desired format (1111222233 -> 1111 222 333)
    if (formattedText.length >= 4) {
      formattedText = formattedText.substring(0, 4) +
          ' ' +
          formattedText.substring(4, formattedText.length);
    }
    if (formattedText.length >= 8) {
      formattedText = formattedText.substring(0, 8) +
          ' ' +
          formattedText.substring(8, formattedText.length);
    }

    return formattedText;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    authController.mobilecontroller.clear();
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
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 64.h,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Login",
                        style: textTheme.headline1
                            ?.copyWith(color: textWhiteColor)),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Enter Mobile Number",
                              style: textTheme.headline2?.copyWith(
                                  color: whiteColor, fontSize: 18.sp)),
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
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: textFieldColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: Text("+91",
                                            style: textTheme.headline1
                                                ?.copyWith(
                                                    color: textWhiteColor)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Expanded(
                                        child: TextFormField(
                                      style: textTheme.headline1
                                          ?.copyWith(color: textWhiteColor),
                                      maxLength: 10,
                                      controller:
                                          authController.mobilecontroller,
                                      textAlign: TextAlign.center,
                                      scrollPadding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      keyboardType: TextInputType.phone,
                                      onChanged: (value) {
                                        // Update the text in the TextField with the formatted text
                                        setState(() {
                                          authController.mobilecontroller.text =
                                              formatText(value);
                                          // Move the cursor to the end of the text
                                          authController
                                                  .mobilecontroller.selection =
                                              TextSelection.fromPosition(
                                            TextPosition(
                                                offset: authController
                                                    .mobilecontroller
                                                    .text
                                                    .length),
                                          );
                                        });
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: aquaGreenColor,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: textFieldColor,
                                                width: 0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: textFieldColor,
                                                width: 0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: textErrorColor,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: textErrorColor,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          hintText: "0000 000 000",
                                          filled: true,
                                          hintStyle: textTheme.headline1
                                              ?.copyWith(
                                                  color: textWhiteColor
                                                      .withOpacity(0.5)),
                                          fillColor: textFieldColor,
                                          counterText: ""),
                                    )
                                        // TextFieldWidget(
                                        //   length: 10,
                                        //   textEditingController: mobile,
                                        //   type: "phone",
                                        //   isNumber: true,
                                        //   // title: "0000 000 000",
                                        //   isRequired: true,
                                        //   scrollBottomPadding: 20,
                                        //   hint: "0000 000 000",

                                        //   // prefix: CountryPickerDropdown(
                                        //   //   initialValue: 'in',
                                        //   //   itemBuilder: _buildDropdownItem,
                                        //   //   onValuePicked: (Country country) {
                                        //   //     print("${country.name}");
                                        //   //   },
                                        //   // ).toString(),
                                        // ),
                                        ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                CustomButton(
                                    height: 8.h,
                                    fontSize: 15.sp,
                                    name: "Continue",
                                    color: aquaGreenColor,

                                    // left: 0.w,
                                    // right: 0.w,
                                    bottom: 3.h,
                                    top: 2.h,
                                    onTap: () async {
                                      // _createAccountDialog(context);
                                      if (_formKey.currentState!.validate() &&
                                          authController.mobilecontroller.text
                                                  .replaceAll(' ', '')
                                                  .length ==
                                              10) {
                                        await Helpers.loader();
                                        final isSuccess =
                                            await authController.login(
                                                mobile: authController
                                                    .mobilecontroller.text
                                                    .replaceAll(' ', ''));
                                        await Helpers.hideLoader();
                                        if (isSuccess) {
                                          _otpDialog(context);
                                        }
                                      } else if (!_formKey.currentState!
                                          .validate()) {
                                        // Helpers.toast("")
                                      } else if (authController
                                              .mobilecontroller.text
                                              .trim()
                                              .length <
                                          10) {
                                        Helpers.toast(
                                            "Number should be must 10 digits");
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("Sign In using Google or Apple",
                        style: textTheme.headline5?.copyWith(
                            color: whiteColor, fontWeight: FontWeight.w100)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: _checkProfileStatus,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/google_icon.png")),
                              ),
                            ),
                          ),
                          Container(
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(31)),
                            child: Center(
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/apple_icon.png")),
                            ),
                          )
                        ],
                      ),
                    ),
                    // CustomButton(
                    //     name: "Create Account",
                    //     color: aquaGreenColor,
                    //     left: 14.w,
                    //     right: 14.w,
                    //     bottom: 5.h,
                    //     top: 2.h,
                    //     onTap: () async {
                    //       _createAccountDialog(context);
                    //     }),
                    // CustomButton(
                    //     name: "Login",
                    //     color: butterflyBlueColor,
                    //     left: 14.w,
                    //     right: 14.w,
                    //     bottom: 5.h,
                    //     onTap: () async {
                    //       _loginDialog(context);
                    //     }),
                  ],
                ),
              ),
            ),
          ],
        )
        // Positioned(
        //   bottom: 0,
        //   child: Container(
        //     height: 73.h,
        //     width: MediaQuery.of(context).size.width,
        //     // child: Text("hellooo", style: TextStyle(color: Colors.amber , fontSize: 60),),
        //     decoration: const BoxDecoration(
        //         color: backgroundColor,
        //         // border: Border(top: BorderSide(color: Colors.white)),
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(30),
        //           topRight: Radius.circular(30),
        //         )),
        //     // child: Text("Login", style: textTheme.headline2?.copyWith(color: textWhiteColor)),
        //     child: Padding(
        //       padding: const EdgeInsets.only(left: 28, right: 28, top: 40),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           Text("Login",
        //               style:
        //                   textTheme.headline1?.copyWith(color: textWhiteColor)),
        //           SizedBox(
        //             height: 3.h,
        //           ),
        //           Container(
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               // mainAxisAlignment: MainAxisAlignment.start,
        //               children: [
        //                 Text("Enter Mobile Number",
        //                     style: textTheme.headline2
        //                         ?.copyWith(color: whiteColor, fontSize: 18.sp)),
        //                 SizedBox(
        //                   height: 1.h,
        //                 ),
        //                 Text(
        //                     "Please Confirm Your Country and Enter Your Mobile Number",
        //                     style: textTheme.headline5?.copyWith(
        //                         color: whiteColor,
        //                         fontWeight: FontWeight.w100)),
        //                 SizedBox(
        //                   height: 4.h,
        //                 ),
        //                 Form(
        //                   key: _formKey,
        //                   child: Column(
        //                     children: [
        //                       TextFieldWidget(
        //                         textEditingController: mobile,
        //                         type: "phone",
        //                         // title: "0000 000 000",
        //                         isRequired: true,
        //                         scrollBottomPadding: 20,
        //                         hint: "0000 000 000",
        //                         // prefix: CountryPickerDropdown(
        //                         //   initialValue: 'in',
        //                         //   itemBuilder: _buildDropdownItem,
        //                         //   onValuePicked: (Country country) {
        //                         //     print("${country.name}");
        //                         //   },
        //                         // ).toString(),
        //                       ),
        //                       SizedBox(
        //                         height: 2.h,
        //                       ),
        //                       CustomButton(
        //                           height: 8.h,
        //                           fontSize: 15.sp,
        //                           name: "Continue",
        //                           color: aquaGreenColor,

        //                           // left: 0.w,
        //                           // right: 0.w,
        //                           bottom: 3.h,
        //                           top: 2.h,
        //                           onTap: () async {
        //                             // _createAccountDialog(context);
        //                             if (_formKey.currentState!.validate() &&
        //                                 mobile.text.trim().length == 10) {
        //                               authController
        //                                   .login(mobile: mobile.text.trim())
        //                                   .then((value) {
        //                                 if (value) {
        //                                   _otpDialog(context);
        //                                 }
        //                               });
        //                             } else if (!_formKey.currentState!
        //                                 .validate()) {
        //                               // Helpers.toast("")
        //                             } else if (mobile.text.trim().length < 10) {
        //                               Helpers.toast(
        //                                   "Number should be must 10 digits");
        //                             }
        //                           }),
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Text("Sign In using Google or Apple",
        //               style: textTheme.headline5?.copyWith(
        //                   color: whiteColor, fontWeight: FontWeight.w100)),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(
        //                 horizontal: 80, vertical: 20),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceAround,
        //               children: [
        //                 InkWell(
        //                   onTap: _checkProfileStatus,
        //                   child: Container(
        //                     height: 60,
        //                     width: 60,
        //                     decoration: BoxDecoration(
        //                         color: whiteColor,
        //                         borderRadius: BorderRadius.circular(30)),
        //                     child: Center(
        //                       child: Image(
        //                           image: AssetImage(
        //                               "assets/images/google_icon.png")),
        //                     ),
        //                   ),
        //                 ),
        //                 Container(
        //                   height: 60,
        //                   width: 60,
        //                   decoration: BoxDecoration(
        //                       color: whiteColor,
        //                       borderRadius: BorderRadius.circular(30)),
        //                   child: Center(
        //                     child: Image(
        //                         image:
        //                             AssetImage("assets/images/apple_icon.png")),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //           // CustomButton(
        //           //     name: "Create Account",
        //           //     color: aquaGreenColor,
        //           //     left: 14.w,
        //           //     right: 14.w,
        //           //     bottom: 5.h,
        //           //     top: 2.h,
        //           //     onTap: () async {
        //           //       _createAccountDialog(context);
        //           //     }),
        //           // CustomButton(
        //           //     name: "Login",
        //           //     color: butterflyBlueColor,
        //           //     left: 14.w,
        //           //     right: 14.w,
        //           //     bottom: 5.h,
        //           //     onTap: () async {
        //           //       _loginDialog(context);
        //           //     }),
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ]),
      // body: Container(
      //   decoration: const BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage("assets/images/login_bg_img.jpeg"),
      //         opacity: 0.5,
      //         fit: BoxFit.fill
      //     ),
      //   ),
      //   child: BodyPaddingWidget(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[
      //         Image.asset("assets/icons/app_icon.png", fit: BoxFit.cover, height: 7.5.h,),
      //         CustomButton(
      //             name: "Continue with Google",
      //             iconWidget: 'assets/icons/google_icon.svg',
      //             left: 14.w,
      //             right: 14.w,
      //             bottom: 2.h,
      //             top: 6.h,
      //             onTap: _checkProfileStatus,
      //         ),
      //         CustomButton(
      //             name: "Continue with Apple",
      //             iconWidget: 'assets/icons/apple_logo_icon.svg',
      //             left: 14.w,
      //             right: 14.w,
      //             bottom: 2.h,
      //             onTap: () {
      //               // context.pushNamed(mainPage);
      //             }),
      //         CustomButton(
      //             name: "Login",
      //             color: butterflyBlueColor,
      //             left: 14.w,
      //             right: 14.w,
      //             bottom: 5.h,
      //             onTap: () async{
      //               _loginDialog(context);
      //             }),
      //         Text("New User ?", style: textTheme.headline3?.copyWith(color: aquaGreenColor, fontWeight: FontWeight.w500)),
      //         CustomButton(
      //             name: "Create Account",
      //             color: aquaGreenColor,
      //             left: 14.w,
      //             right: 14.w,
      //             bottom: 5.h,
      //             top: 2.h,
      //             onTap: () async{
      //               _createAccountDialog(context);
      //             }),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  void _otpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OTPDialog(
            otp: otp,
            onVerify: () async {
              Helpers.loader();
              final isSuccess = await authController.sendAndVerifyOTP(
                  mobile:
                      authController.mobilecontroller.text.replaceAll(' ', ''),
                  otp: otp.text);
              Helpers.hideLoader();
              if (!mounted) return;
              if (isSuccess) {
                profileController.getProfile().then((value) async {
                  if (value) {
                     print("profileeee ${profileController.profile}");
                print("name >>> ${profileController.profile.name}");
                print(
                    "Displayname >>> ${profileController.profile.displayName}");
                print("dob >>> ${profileController.profile.dob}");
                if (profileController.profile.name != null ||
                    profileController.profile.displayName != null ||
                    profileController.profile.dob != null) {
                       await authController.loggedUserIn();
                    context.goNamed(mainPage);
                    }else {
                    _showCreateProfileBottomSheet(context);
                  }
                   
                  } else {
                    _showCreateProfileBottomSheet(context);
                  }
                });
                // print("profileeee ${profileController.profile}");
                // print("name >>> ${profileController.profile.name}");
                // print(
                //     "Displayname >>> ${profileController.profile.displayName}");
                // print("dob >>> ${profileController.profile.dob}");
                // if (profileController.profile.name != null ||
                //     profileController.profile.displayName != null ||
                //     profileController.profile.dob != null) {
                //   await authController.loggedUserIn();
                //   context.goNamed(mainPage);
                // } else {
                //   _showCreateProfileBottomSheet(context);
                // }
              } else {
                _showCreateProfileBottomSheet(context);
              }
            });
      },
    );
  }

  Future<void> _checkProfileStatus() async {
    Helpers.loader();
    final auth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      'email',
      // 'https://www.googleapis.com/auth/user.phonenumbers.read',
    ]);
    // if (googleSignIn.) {

    // }
    // googleSignIn.onCurrentUserChanged
    //     .listen((GoogleSignInAccount? account) async {
    //   unawaited(authController.handleGetData(account!));
    // });
    // authController.handleGetData();
    if (await googleSignIn.isSignedIn()) {
      await auth.signOut();
      await googleSignIn.signOut();
    }
    final isSuccess = await authController.googleSignInMethod(context);
    if (isSuccess) {
      await profileController.getProfile();
      if (!mounted) return;
      if (profileController.profile.displayName == null) {
        Helpers.hideLoader();
        context.goNamed(loginPage);
        // _showCreateProfileBottomSheet(context);
      } else {
        await authController.loggedUserIn();
        Helpers.hideLoader();
        context.goNamed(mainPage);
      }
    } else {
      Helpers.hideLoader();
    }
  }

  void _createAccountDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return const CustomBottomSheet(
            initialChildSize: 0.97,
            maxChildSize: 0.97,
            minChildSize: 0.5,
            isDismissible: false,
            child: CreateAccount());
      },
    );
  }

  void _loginDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const CustomBottomSheet(
              isDismissible: false,
              initialChildSize: 0.5,
              maxChildSize: 0.9,
              minChildSize: 0.5,
              child: Login()),
        );
      },
    );
  }

  void _showCreateProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const CustomBottomSheet(
              isDismissible: false,
              initialChildSize: 0.97,
              maxChildSize: 0.97,
              minChildSize: 0.5,
              child: CreateProfileCard(
                  // from: 'signIn',
                  )),
        );
      },
    );
  }
}

Widget _buildDropdownItem(Country country) => Container(
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text("+${country.phoneCode}(${country.isoCode})"),
        ],
      ),
    );



// profileeee UserModel(104, akshay, null, null, null, null)
// I/flutter (22361): name >>> akshay
// I/flutter (22361): Displayname >>> akki
// I/flutter (22361): dob >>> 2023-11-23 00:00:00.000
// I/flutter (22361): Api Url => '********************************************* Payload {user_id: null}
// I/flutter (22361): Api Token eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDIyNzcxMjYsImlkIjoxMDQsImVtYWlsIjoiIiwiaWF0IjoxNzAxNjcyMzI2fQ.wLV3czdJuPpdac7MdyZx_HGS2HxNP-SkHNoLidjlojt8KE19E6dryAaIC7zqyeUwvaEbfhTQdTPGErFf5cUYAg
// I/flutter (22361): ban till null
// I/flutter (22361): Api Url => '*************************************************** Payload null
// I/flutter (22361): Api Url => '********************************************************* Payload null
// I/flutter (22361): Api Url => '************************************************************** Payload null
// I/flutter (22361): Api Url => '*************************************************** Payload {name: null, page: , catgeory_id: }       
// I/flutter (22361): Api Url => '********************************************** Payload {name: null, page: }
// I/flutter (22361): /user-profile response 200 with OK


//  profileeee User(null, null, null, null, null, null)
// I/flutter (23036): name >>> null
// I/flutter (23036): Displayname >>> null
// I/flutter (23036): dob >>> null
// I/flutter (23036): Api Url => '********************************************* Payload {user_id: null}
// I/flutter (23036): /user-profile response 200 with OK