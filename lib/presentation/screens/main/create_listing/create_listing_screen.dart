import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:loby/presentation/screens/main/create_listing/widgets/HoursDropDown.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../../widgets/bottom_dialog_widget.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/input_text_title_widget.dart';
import '../../../widgets/input_text_widget.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({Key? key}) : super(key: key);

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body(),
      ),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 8.0),
                        child: Text(
                          'Create New Listing',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headline2
                              ?.copyWith(color: textWhiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const MyDropDownWidget(),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        textAlign: TextAlign.start,
                        "Disclaimer",
                        style: textTheme.headline4
                            ?.copyWith(color: textWhiteColor)),
                  ),
                  const SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    '1. For Accounts That Cannot Change Email Address : ',
                                style: textTheme.headline6?.copyWith(
                                    color: textLightColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                  text:
                                      'Sellers must provide the email address to the buyers and make sure they gain full access of the email such as secret questions etc.',
                                  style: textTheme.headline6?.copyWith(
                                      color: textLightColor,
                                      fontWeight: FontWeight.w300)),
                            ])),
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    '2. For Accounts That Can Change Email Address : ',
                                style: textTheme.headline6?.copyWith(
                                    color: textLightColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                  text:
                                      'Sellers must assist buyers to change the email address and provide the proof',
                                  style: textTheme.headline6?.copyWith(
                                      color: textLightColor,
                                      fontWeight: FontWeight.w300)),
                            ])),
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text: '',
                                style: textTheme.headline6?.copyWith(
                                    color: textLightColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                  text:
                                      '3. Payment will be put on hold if seller did not submit proof for (1) or (2). If seller fails to provide proof, the payment will be deducted to refund buyer when there is a dispute.',
                                  style: textTheme.headline6?.copyWith(
                                      color: textLightColor,
                                      fontWeight: FontWeight.w300)),
                            ])),
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text: '',
                                style: textTheme.headline6?.copyWith(
                                    color: textLightColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                  text:
                                      '4. You must be the main owner of the account(s) you intend to sell.',
                                  style: textTheme.headline6?.copyWith(
                                      color: textLightColor,
                                      fontWeight: FontWeight.w300)),
                            ])),
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text: '',
                                style: textTheme.headline6?.copyWith(
                                    color: textLightColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                  text:
                                      '5. Visit Accounts Service Rules and Descriptions for more info.',
                                  style: textTheme.headline6?.copyWith(
                                      color: textLightColor,
                                      fontWeight: FontWeight.w300)),
                            ])),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const MyDropDownWidget(),
                  const SizedBox(height: 16.0),
                  const MyDropDownWidget(),
                  const SizedBox(height: 16.0),
                  const InputTextTitleWidget(
                      titleName: 'Title', titleTextColor: textInputTitleColor),
                  const SizedBox(height: 16.0),
                  InputTextWidget(
                    hintName: 'Enter Title',
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return Helpers.validateField(value!);
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        textAlign: TextAlign.center,
                        "For safety reasons, sellers are not allowed to leave their personal contacts. All communications with the buyers can only be made using Loby chat. Any conversation outside Loby Chat will not be insured/covered by Loby Protection",
                        style: textTheme.headline6
                            ?.copyWith(color: textLightColor)),
                  ),
                  const SizedBox(height: 16.0),
                  const InputTextTitleWidget(
                      titleName: 'Description',
                      titleTextColor: textInputTitleColor),
                  const SizedBox(height: 16.0),
                  InputTextWidget(
                    hintName: 'Type Description',
                    maxLines: 5,
                    verticalHeight: 16.0,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return Helpers.validateField(value!);
                    },
                  ),
                  const SizedBox(height: 16.0),
                  _buildUploadField(textTheme),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        textAlign: TextAlign.start,
                        'Price',
                        style: textTheme.headline4
                            ?.copyWith(color: textLightColor)),
                  ),
                  const SizedBox(height: 16.0),
                  _buildPrice(textTheme),
                  const SizedBox(height: 16.0),
                  InputTextWidget(
                    hintName: 'Available Stock (1 to Infinite)',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return Helpers.validateField(value!);
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "‘Loby Protection’",
                            style: textTheme.headline4?.copyWith(
                                fontSize: 13.0, color: aquaGreenColor),
                          ),
                          TextSpan(
                              text: " Insurance",
                              style: textTheme.headline4?.copyWith(
                                  fontSize: 13.0, color: textLightColor)),
                        ])),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: aquaGreenColor,
                            border: Border.all(color: aquaGreenColor)),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: SizedBox(
                            child: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: '7 Days Insurance',
                                    style: textTheme.headline4?.copyWith(
                                        fontSize: 13.0, color: textLightColor),
                                  ),
                                ]))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        textAlign: TextAlign.start,
                        'Estimated Delivery Time (Days)',
                        style: textTheme.headline4
                            ?.copyWith(color: textLightColor)),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    child: _buildSearchField(textTheme, 'Select'),
                  ),
                  const SizedBox(height: 16.0),
                  _buildTermsCheckbox(
                      textTheme,
                      'I have read and agreed to all sellers policy and the ',
                      'Terms of Service.'),
                  const SizedBox(height: 16.0),
                  CustomButton(
                    color: createProfileButtonColor,
                    name: "Publish",
                    textColor: textWhiteColor,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        BottomDialog(
                                textTheme: textTheme,
                                tileName: "Congratulations",
                                titleColor: aquaGreenColor,
                                contentName:
                                    "Your service has been successfully listed. You can edit your listings from My Listings.",
                                contentLinkName: ' My Listings')
                            .showBottomDialog(context);
                      }
                      /*BottomDialog(
                              textTheme: textTheme,
                              tileName: "Congratulations",
                              titleColor: aquaGreenColor,
                              contentName:
                                  "Your service has been successfully listed. You can edit your listings from My Listings.",
                              contentLinkName: ' My Listings')
                          .showBottomDialog(context);*/
                    },
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildTermsCheckbox(TextTheme textTheme, String content, String textSpan) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCheckbox(
          isChecked: isChecked,
          onChange: (value) {
            isChecked = value;
          },
          backgroundColor: aquaGreenColor,
          borderColor: aquaGreenColor,
          icon: Icons.check,
          size: 22,
          iconSize: 16,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: SizedBox(
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(
                      text: content,
                      style: textTheme.headline4
                          ?.copyWith(fontSize: 13.0, color: textLightColor),
                    ),
                    TextSpan(
                        text: textSpan,
                        style: textTheme.headline4
                            ?.copyWith(fontSize: 13.0, color: aquaGreenColor)),
                  ]))),
        ),
      ],
    );
  }

  _buildPrice(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: const InputTextWidget(
            hintName: '₹ ',
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 2.0),
        Text(
          "per",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: textTheme.headline4
              ?.copyWith(fontSize: 13.0, color: textLightColor),
        ),
        const SizedBox(width: 2.0),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Container(
                constraints: const BoxConstraints(
                  minHeight: 47,
                  minWidth: double.infinity,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(10)),
                child: HoursDropDownDivider())),
      ],
    );
  }

  _buildSearchField(TextTheme textTheme, String name) {
    return const MyDropDownWidget(
      hintTxt: 'Select',
    );
  }

  _buildUploadField(TextTheme textTheme) {
    return DottedBorder(
      color: iconTintColor,
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      strokeWidth: 1,
      child: Container(
          decoration: BoxDecoration(
            color: textFieldColor,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                      textAlign: TextAlign.start,
                      "Upload Images or Videos",
                      style:
                          textTheme.headline4?.copyWith(color: textWhiteColor)),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // This is your Badge
                    padding: const EdgeInsets.all(8),
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.1,
                        minWidth: MediaQuery.of(context).size.width * 0.4),
                    decoration: BoxDecoration(
                      // This controls the shadow
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 5,
                            color: Colors.black.withAlpha(50))
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: iconWhiteColor, // This would be color of the Badge
                    ), // This is your Badge
                    child: Center(
                      // Here you can put whatever content you want inside your Badge
                      child: Text('',
                          style: textTheme.headline1
                              ?.copyWith(color: textLightColor)),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    // This is your Badge
                    padding: const EdgeInsets.all(8),
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.1,
                        minWidth: MediaQuery.of(context).size.width * 0.4),
                    decoration: BoxDecoration(
                      // This controls the shadow
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 5,
                            color: Colors.black.withAlpha(50))
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: iconWhiteColor, // This would be color of the Badge
                    ), // This is your Badge
                    child: Center(
                      // Here you can put whatever content you want inside your Badge
                      child: Text('',
                          style: textTheme.headline1
                              ?.copyWith(color: textLightColor)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // This is your Badge
                    padding: const EdgeInsets.all(8),
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.1,
                        minWidth: MediaQuery.of(context).size.width * 0.4),
                    decoration: BoxDecoration(
                      // This controls the shadow
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 5,
                            color: Colors.black.withAlpha(50))
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: iconWhiteColor, // This would be color of the Badge
                    ), // This is your Badge
                    child: Center(
                      // Here you can put whatever content you want inside your Badge
                      child: Text('',
                          style: textTheme.headline1
                              ?.copyWith(color: textLightColor)),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    // This is your Badge
                    padding: const EdgeInsets.all(8),
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.1,
                        minWidth: MediaQuery.of(context).size.width * 0.4),
                    decoration: BoxDecoration(
                      // This controls the shadow
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 5,
                            color: Colors.black.withAlpha(50))
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: iconWhiteColor, // This would be color of the Badge
                    ), // This is your Badge
                    child: Center(
                      // Here you can put whatever content you want inside your Badge
                      child: Text('',
                          style: textTheme.headline1
                              ?.copyWith(color: textLightColor)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.h),
                child: CustomButton(
                  color: createProfileButtonColor,
                  name: "Choose file",
                  textColor: textWhiteColor,
                  iconWidget: 'assets/icons/upload_img_icon.svg',
                  onTap: () {
                    debugPrint('click chat');
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                      textAlign: TextAlign.start,
                      "or",
                      style:
                          textTheme.headline4?.copyWith(color: textWhiteColor)),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InputTextWidget(
                  hintName: 'Paste Youtube/Twitch Link',
                  txtHintColor: whiteColor,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    return Helpers.validateField(value!);
                  },
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          )),
    );
  }
}
