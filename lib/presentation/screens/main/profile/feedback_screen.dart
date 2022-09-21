import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/buttons/custom_button.dart';
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
    return Column(
      children: [
        CustomAppBar(
          appBarName: "Feedback/Suggestions",
        ),
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
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
                        child: Container(
                          height: 45,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                  const BorderSide(
                                    style: BorderStyle.solid,
                                    color: orangeColor,
                                    width: 1.0,
                                  ),
                                ),
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    )),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    backgroundDarkJungleGreenColor),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                                child: Text("Clear",
                                    style: textTheme.button
                                        ?.copyWith(color: orangeColor)),
                              )),
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
            ),
          ),
        )
      ],
    );
  }
}
