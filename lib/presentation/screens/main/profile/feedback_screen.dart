import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/input_text_title_widget.dart';
import '../../../widgets/input_text_widget.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen> {
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
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 7.h,
                  height: 7.h,
                  child: MaterialButton(
                    shape: const CircleBorder(),
                    color: backgroundBalticSeaColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).unfocus();
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
                        'Feedback/Suggestions',
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
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      style:
                          textTheme.bodyText1?.copyWith(color: textWhiteColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle:
                            textTheme.headline5?.copyWith(color: iconTintColor),
                        hintText:
                            'Type your feedback & suggestions for us to improve. You can also suggest new features you want to see.',
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 4.h,
                ),
                const InputTextTitleWidget(
                    titleName: 'Email', titleTextColor: textInputTitleColor),
                SizedBox(
                  width: double.infinity,
                  height: 2.h,
                ),
                const InputTextWidget(
                    hintName: 'We will get in touch with you on this email'),
                SizedBox(
                  width: double.infinity,
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: CustomButton(
                        color: orangeColor,
                        textColor: textWhiteColor,
                        name: "Clear",
                        onTap: () {
                          debugPrint('click chat');
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: CustomButton(
                        color: aquaGreenColor,
                        textColor: textBlackColor,
                        name: "Submit",
                        onTap: () {
                          debugPrint('click chat');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
