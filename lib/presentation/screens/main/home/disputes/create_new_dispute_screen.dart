import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../widgets/custom_button.dart';
import '../widgets/dispute_widget.dart';

class CreateNewDispute extends StatefulWidget {
  const CreateNewDispute({Key? key}) : super(key: key);

  @override
  State<CreateNewDispute> createState() => _CreateNewDisputeState();
}

class _CreateNewDisputeState extends State<CreateNewDispute> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 7.h,
                        height: 7.h,
                        child: MaterialButton(
                          shape: const CircleBorder(),
                          color: backgroundBalticSeaColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            'assets/icons/back_icon.svg',
                            color: whiteColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 8.0),
                            child: Text(
                              'My Disputes',
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
              ],
            ),
          ),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
            child: DisputeWidget(
                disputeType: "Open",
                currentStatus: ''),
          ),
          const SizedBox(height: 16.0),
          _buildUploadField(textTheme),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: textFieldColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                child: TextField(
                  style:
                  textTheme.bodyText1?.copyWith(color: textWhiteColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle:
                    textTheme.headline5?.copyWith(color: iconTintColor),
                    hintText:
                    'Write your comments !',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.h),
            child: CustomButton(
              color: orangeColor,
              name: "Submit",
              textColor: textWhiteColor,
              onTap: () {
                debugPrint('click chat');
              },
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  _buildYoutubeLinkPasteField(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: Container(
          decoration: BoxDecoration(
            color: textFieldColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              child: TextFormField(
                  style: textTheme.subtitle1
                      ?.copyWith(fontSize: 14, color: whiteColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle:
                        textTheme.bodyText1?.copyWith(color: textWhiteColor),
                    hintText: 'Paste Youtube/Twitch Link',
                  )))),
    );
  }

  _buildUploadField(TextTheme textTheme) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        child: DottedBorder(
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                          textAlign: TextAlign.start,
                          "Upload Images or Videos",
                          style: textTheme.headline4
                              ?.copyWith(color: textWhiteColor)),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // This is your Badge
                        padding: const EdgeInsets.all(8),
                        constraints:
                            BoxConstraints(minHeight: 12.h, minWidth: 36.w),
                        decoration: BoxDecoration(
                          // This controls the shadow
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 5,
                                color: Colors.black.withAlpha(50))
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color:
                              iconWhiteColor, // This would be color of the Badge
                        ), // This is your Badge
                        child: Center(
                          // Here you can put whatever content you want inside your Badge
                          child: Text('1',
                              style: textTheme.headline5
                                  ?.copyWith(color: textLightColor)),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        // This is your Badge
                        padding: const EdgeInsets.all(8),
                        constraints:
                            BoxConstraints(minHeight: 12.h, minWidth: 36.w),
                        decoration: BoxDecoration(
                          // This controls the shadow
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 5,
                                color: Colors.black.withAlpha(50))
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color:
                              iconWhiteColor, // This would be color of the Badge
                        ), // This is your Badge
                        child: Center(
                          // Here you can put whatever content you want inside your Badge
                          child: Text('1',
                              style: textTheme.headline5
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
                        constraints:
                            BoxConstraints(minHeight: 12.h, minWidth: 36.w),
                        decoration: BoxDecoration(
                          // This controls the shadow
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 5,
                                color: Colors.black.withAlpha(50))
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color:
                              iconWhiteColor, // This would be color of the Badge
                        ), // This is your Badge
                        child: Center(
                          // Here you can put whatever content you want inside your Badge
                          child: Text('1',
                              style: textTheme.headline5
                                  ?.copyWith(color: textLightColor)),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        // This is your Badge
                        padding: const EdgeInsets.all(8),
                        constraints:
                            BoxConstraints(minHeight: 12.h, minWidth: 36.w),
                        decoration: BoxDecoration(
                          // This controls the shadow
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 5,
                                color: Colors.black.withAlpha(50))
                          ],
                          borderRadius: BorderRadius.circular(12),
                          color:
                              iconWhiteColor, // This would be color of the Badge
                        ), // This is your Badge
                        child: Center(
                          // Here you can put whatever content you want inside your Badge
                          child: Text('1',
                              style: textTheme.headline5
                                  ?.copyWith(color: textLightColor)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.h),
                    child: CustomButton(
                      color: createProfileButtonColor,
                      name: "Choose file",
                      textColor: textWhiteColor,
                      onTap: () {
                        debugPrint('click chat');
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                          textAlign: TextAlign.start,
                          "or",
                          style: textTheme.headline4
                              ?.copyWith(color: textWhiteColor)),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _buildYoutubeLinkPasteField(textTheme),
                  const SizedBox(height: 16.0),
                ],
              )),
        ));
  }
}
