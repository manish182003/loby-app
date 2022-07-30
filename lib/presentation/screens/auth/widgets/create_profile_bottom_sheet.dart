import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/input_text_title_widget.dart';
import '../../../widgets/input_text_widget.dart';
import '../../main/main_screen.dart';

class CreateProfileCard extends StatefulWidget {
  final ScrollController controller;

  const CreateProfileCard(this.controller);

  @override
  State<CreateProfileCard> createState() => _CreateProfileCardState();
}

class _CreateProfileCardState extends State<CreateProfileCard> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView.builder(
        controller: widget.controller,
        // assign controller here
        itemCount: 1,
        itemBuilder: (_, index) => Padding(
              padding: EdgeInsets.all(4.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Your Profile',
                            style: textTheme.headline2
                                ?.copyWith(color: textWhiteColor)),
                        IconButton(
                          icon: const Icon(Icons.close, color: whiteColor),
                          onPressed: () => Navigator.of(context).pop(null),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    _buildRow(textTheme),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const Divider(
                      thickness: 1.2,
                      color: dividerColor,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Full Name',
                        titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    InputTextWidget(
                      hintName: 'Ex: Jhon Singh',
                      validator: (value) {
                        return Helpers.validateField(value!);
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Display Name',
                        titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    InputTextWidget(
                      hintName: 'Ex: Commander',
                      validator: (value) {
                        return Helpers.validateField(value!);
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Country',
                        titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const InputTextWidget(hintName: 'India (Default)'),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'City', titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const InputTextWidget(hintName: 'Ex: Bhopal'),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Date Of Birth',
                        titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    InputTextWidget(hintName: '15 July 1999',
                      validator: (value) {
                        return Helpers.validateField(value!);
                      },),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Profile Tag',
                        titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const InputTextWidget(hintName: 'tag'),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    _buildSearchField(textTheme),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Bio', titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    _buildBioNameField(textTheme),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomButton(
                        color: purpleLightIndigoColor,
                        textColor: textWhiteColor,
                        name: "Update Profile",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MainScreen()));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget _buildSearchField(TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        style: textTheme.headline4?.copyWith(color: textWhiteColor),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(
              'assets/icons/search_icon.svg',
              color: iconWhiteColor,
              height: 12,
              width: 12,
            ),
          ),
          border: InputBorder.none,
          hintStyle: textTheme.headline4?.copyWith(color: textWhiteColor),
          hintText: 'Type Tags',
        ),
      ),
    );
  }

  Widget _buildRow(TextTheme textTheme) {
    return Row(
      children: <Widget>[
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage("assets/icons/app_icon.png"),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(aquaGreenColor),
                      ),
                      onPressed: () {
                        debugPrint("change");
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                        child: Text("Upload New", style: textTheme.button),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(textFieldColor),
                      ),
                      onPressed: () {
                        debugPrint('clicked');
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                        child: Text("Delete Avatar",
                            style:
                                textTheme.button?.copyWith(color: whiteColor)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildBioNameField(TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: TextFormField(
          style: textTheme.headline4?.copyWith(color: whiteColor),
          maxLines: 4,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle:
                textTheme.headline4?.copyWith(color: textInputTitleColor),
            hintText: 'Ex: Jhon Singh',
          ),
        ),
      ),
    );
  }
}
