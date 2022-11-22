import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../services/routing_service/routes_name.dart';
import '../../../widgets/bottom_dialog.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/buttons/custom_button.dart';


class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen> {

  ProfileController profileController = Get.find<ProfileController>();

  TextEditingController feedback = TextEditingController();
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar(context: context, appBarName: 'Feedback/Suggestions'),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldWidget(
                  textEditingController: feedback,
                  hint: 'Type your feedback & suggestions for us to improve. You can also suggest new features you want to see.',
                  isRequired: true,
                  maxLines: 14,
                  textInputAction: TextInputAction.newline,
                ),
                SizedBox(height: 4.h),
                TextFieldWidget(
                  textEditingController: email,
                  title: 'Email',
                  type: 'email',
                  hint: 'We will get in touch with you on this email',
                  isRequired: true,
                ),
                SizedBox(
                  height: 8.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: CustomButton(
                        name: "Clear",
                        outlineBtn: true,
                        borderColor: orangeColor,
                        textColor: orangeColor,
                        onTap: () async {
                          feedback.clear();
                          email.clear();
                        },
                      ),
                    ),
                    SizedBox(width: 4.w,),
                    Expanded(
                      flex: 4,
                      child: CustomButton(
                        color: aquaGreenColor,
                        textColor: textBlackColor,
                        name: "Submit",
                        onTap: ()async {
                          if(_formKey.currentState!.validate()){
                            Helpers.loader();
                            final isSuccess = await profileController.submitFeedback(feedback: feedback.text, email: email.text);
                            Helpers.hideLoader();
                            if(isSuccess){
                              BottomDialog(
                                  textTheme: textTheme,
                                  titleColor: aquaGreenColor,
                                  contentName: "Thank you for your feedback.",
                                  onOk: (){
                                    Navigator.pop(context);
                                    context.goNamed(mainPage);
                                  }
                              ).showBottomDialog(context);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
