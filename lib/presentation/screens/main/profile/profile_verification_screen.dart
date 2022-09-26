import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../widgets/bottom_dialog_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/input_text_title_widget.dart';
import '../../../widgets/input_text_widget.dart';

class ProfileVerificationScreen extends StatefulWidget {
  const ProfileVerificationScreen({Key? key}) : super(key: key);

  @override
  State<ProfileVerificationScreen> createState() =>
      _ProfileVerificationScreenState();
}

class _ProfileVerificationScreenState extends State<ProfileVerificationScreen> {

  ProfileController profileController = Get.find<ProfileController>();

  TextEditingController displayName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController youtube = TextEditingController();
  TextEditingController twitch = TextEditingController();
  TextEditingController instagram = TextEditingController();

  List<PlatformFile> _paths = [];
  File imageFile = File('');
  final _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar(context: context, appBarName: "Profile Verification"),
      body: BodyPaddingWidget(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                    textAlign: TextAlign.center,
                    "Get your profile verified if you are an gaming influencer, sports athlete or a content creator",
                    style: textTheme.headline5?.copyWith(color: orangeColor)),
                SizedBox(height: 4.h,),
                TextFieldWidget(
                  textEditingController: displayName,
                  title: "IGN / Display Name",
                  isRequired: true,
                ),
                SizedBox(height: 3.h,),
                TextFieldWidget(
                  textEditingController: name,
                  title: "Name (as per Official Documents)",
                  isRequired: true,
                ),
                SizedBox(height: 3.h,),
                TextFieldWidget(
                  textEditingController: message,
                  title: "Message",
                  isRequired: true,
                  maxLines: 5,
                ),
                SizedBox(height: 3.h,),
                TextFieldWidget(
                  textEditingController: youtube,
                  title: "Youtube Link",
                  isRequired: true,
                ),
                SizedBox(height: 3.h,),
                TextFieldWidget(
                  textEditingController: twitch,
                  title: "Twitch Link",
                  isRequired: true,
                ),
                SizedBox(height: 3.h,),
                TextFieldWidget(
                  textEditingController: instagram,
                  title: "Instagram Link",
                  isRequired: true,
                ),
                SizedBox(height: 3.h,),
                const InputTextTitleWidget(
                    titleName: 'Upload Documents',
                    titleTextColor: textWhiteColor),
                SizedBox(height: 1.h,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      textAlign: TextAlign.start,
                      "Please upload a photo with your passport / ID & your selfie",
                      style:
                      textTheme.headline6?.copyWith(color: textLightColor)),
                ),
                SizedBox(height: 3.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _documentTile(textTheme, "assets/icons/id_card_icon.svg", "Copy of your passport or ID card", onTap: _openFileExplorer, isSelected: _paths.isEmpty),
                    SizedBox(width: 1.h),
                    _documentTile(textTheme, "assets/icons/camera_icon.svg", "Selfie",onTap: (){Helpers.showImagePicker(context: context, onGallery: _imgFromGallery, onCamera: _imgFromCamera);}, isSelected: imageFile.path.isEmpty),
                  ],
                ),
                SizedBox(height: 5.h,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: CustomButton(
                      color: butterflyBlueColor,
                      name: "Submit",
                      textColor: primaryTextColor,
                      onTap: () async{

                        if(profileController.profile.verifiedProfile ?? false){
                          Helpers.toast("Your Profile Has Already Been Verified");
                        }else{
                          if(_formKey.currentState!.validate()){
                            await Helpers.loader();
                            final isSuccess = await profileController.profileVerification(
                              displayName: displayName.text,
                              name: name.text,
                              message: message.text,
                              youtube: youtube.text,
                              twitch: twitch.text,
                              instagram: instagram.text,
                              idCard: File(_paths.first.path!),
                              selfie: imageFile,
                            );
                            await Helpers.hideLoader();
                            if(isSuccess){
                              BottomDialog(
                                textTheme: textTheme,
                                titleColor: aquaGreenColor,
                                contentName:
                                "Your profile has been submitted to Team Loby for verification. We will revert back to you shortly",)
                                  .showBottomDialog(context);
                            }
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 8.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _documentTile(TextTheme textTheme, String icon, String title, {Function()? onTap, required bool isSelected}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 5,
                color: Colors.black.withAlpha(50))
          ],
          borderRadius: BorderRadius.circular(12),
          color: textFieldColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                isSelected ? icon : 'assets/icons/tick.svg',
                width: 5.h,
                height: 5.h,
              ),
              SizedBox(height: 1.h),
              Text(isSelected ? title : 'Selected',
                  textAlign: TextAlign.center,
                  style: textTheme.subtitle1?.copyWith(color: textLightColor)),
            ],
          ),
        ),
      ),
    );
  }

  void _openFileExplorer() async {
    try {

      _paths = (await FilePicker.platform.pickFiles(
        onFileLoading: (FilePickerStatus status) => print(status),
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      ))!.files;
      setState((){});

    } on PlatformException catch (e) {
      Helpers.toast('Unsupported operation$e');
    } catch (e) {
      Helpers.toast('Something went wrong');
    }
    if (!mounted) return;
  }


  _imgFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        imageFile = File(image.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  _imgFromCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (image != null) {
        imageFile = File(image.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }





}
