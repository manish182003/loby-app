import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/auth/selected_file.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../../widgets/single_selectable_card.dart';
import '../../../../../widgets/text_fields/text_field_widget.dart';

//ignore: must_be_immutable
class SelectDuelWinnerDialog extends StatelessWidget {
  final Function(Object?)? onSelectWinner;
  final Function() onSubmit;
  final List<String>? options;
  final bool? isNormalOrder;
  SelectDuelWinnerDialog(
      {super.key,
      this.onSelectWinner,
      required this.onSubmit,
      this.options,
      this.isNormalOrder = false});

  OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(isNormalOrder ?? false ? "Upload Proofs" : "Select Winner",
                    style: textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w500, color: whiteColor)),
                GestureDetector(
                    onTap: () {
                      orderController.fileLink.value.clear();
                      orderController.selectedDuelProofs.clear();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: whiteColor,
                    )),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            isNormalOrder ?? false
                ? const SizedBox()
                : Obx(() {
                    final selectedUser = orderController.selectedUser.value;
                    return SingleSelectableCard(
                      options: options!,
                      onSelected: onSelectWinner!,
                    );

                    //   Wrap(
                    //   children: List.from(
                    //     options!.map((winner) {
                    //       final selectedUser = orderController.selectedUser.value;
                    //       return SizedBox(
                    //         child: RadioListTile(
                    //             selected: selectedUser == winner,
                    //             groupValue: selectedUser,
                    //             dense: true,
                    //             contentPadding: const EdgeInsets.all(0),
                    //             controlAffinity: ListTileControlAffinity.leading,
                    //             title: Text(winner, style: textTheme.headline3?.copyWith(fontWeight: FontWeight.w500, color: whiteColor)),
                    //             value: winner,
                    //             activeColor: aquaGreenColor,
                    //             onChanged: onSelectWinner
                    //         ),
                    //       );
                    //     }).toList(),
                    //   )
                    //   ,
                    // );
                  }),
            SizedBox(
              height: 3.h,
            ),
            _buildUploadField(textTheme),
            SizedBox(
              height: 5.h,
            ),
            CustomButton(
                top: 0.h,
                left: 20.w,
                right: 20.w,
                height: 6.h,
                bottom: 1.h,
                color: aquaGreenColor, //createProfileButtonColor,
                name: "Submit",
                fontSize: 12.spa,
                textColor: textBlackColor,
                onTap: onSubmit),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadField(TextTheme textTheme) {
    return DottedBorder(
      color: iconTintColor,
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      strokeWidth: 1,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
          decoration: BoxDecoration(
            color: textFieldColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Text(
                  textAlign: TextAlign.center,
                  "Upload Images or Videos",
                  style: textTheme.headlineMedium
                      ?.copyWith(color: textWhiteColor)),
              SizedBox(height: 3.h),
              Obx(() {
                if (orderController.selectedDuelProofs.isEmpty) {
                  return const SizedBox();
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                    ),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: orderController.selectedDuelProofs.length,
                    itemBuilder: (context, index) {
                      return selectedFileTile(context,
                          image: orderController.selectedDuelProofs[index],
                          index: index);
                    },
                  );
                }
              }),
              CustomButton(
                  top: 0.h,
                  left: 13.w,
                  right: 13.w,
                  bottom: 1.h,
                  color: createProfileButtonColor,
                  name: "Choose file",
                  textColor: textWhiteColor,
                  iconWidget: 'assets/icons/upload_img_icon.svg',
                  onTap: _openFileExplorer),
              SizedBox(height: 2.h),
              Text("or",
                  style: textTheme.headlineMedium
                      ?.copyWith(color: textWhiteColor)),
              SizedBox(height: 1.h),
              TextFieldWidget(
                textEditingController: orderController.fileLink.value,
                hint: 'Paste Youtube/Twitch/Drive Link',
                type: 'optionalLink',
                isRequired: true,
              ),
            ],
          )),
    );
  }

  // Widget selectedFileTile(BuildContext context,
  //     {required SelectedFile image, required int index}) {
  //   return Container(
  //     padding: const EdgeInsets.all(8),
  //     constraints: BoxConstraints(
  //         minHeight: MediaQuery.of(context).size.height * 0.08,
  //         minWidth: MediaQuery.of(context).size.width * 0.4),
  //     decoration: BoxDecoration(
  //       boxShadow: [
  //         BoxShadow(
  //             spreadRadius: 1, blurRadius: 5, color: Colors.black.withAlpha(50))
  //       ],
  //       borderRadius: BorderRadius.circular(12),
  //       color: iconWhiteColor,
  //       image: DecorationImage(image: FileImage(image.file), fit: BoxFit.cover),
  //     ),
  //     child: GestureDetector(
  //       onTap: () {
  //         orderController.selectedDuelProofs.removeAt(index);
  //       },
  //       child: Align(
  //         alignment: AlignmentDirectional.topEnd,
  //         child: SvgPicture.asset(
  //           'assets/icons/close_icon.svg',
  //           color: selectiveYellowColor,
  //           width: 8,
  //           height: 8,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget selectedFileTile(BuildContext context,
      {required SelectedFile image, required int index}) {
    return StatefulBuilder(
      builder: (context, setState) {
        String? videoImage;
        bool isLoading = false;
        Rx<double> loadingValue = 0.0.obs;

        return FutureBuilder<String?>(
          future: () async {
            if (image.file.path.toLowerCase().endsWith('.mp4')) {
              isLoading = true;

              return await VideoThumbnail.thumbnailFile(
                video: image.file.path,
                imageFormat: ImageFormat.PNG,
              );
            } else {
              return null;
            }
          }(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                snapshot.data == null) {
              Timer.periodic(
                Duration(milliseconds: 100),
                (timer) {
                  if (loadingValue.value < 1) {
                    loadingValue.value += 0.1;
                  } else {
                    timer.cancel();
                  }
                },
              );
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: iconWhiteColor,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(
                    () => LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(8),
                      minHeight: 5,
                      valueColor: AlwaysStoppedAnimation<Color>(aquaGreenColor),
                      value: loadingValue.value,
                    ),
                  ),
                ),
              );
            }
            videoImage = snapshot.data;
            return Container(
              padding: const EdgeInsets.all(8),
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.08,
                  minWidth: MediaQuery.of(context).size.width * 0.4),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 5,
                      color: Colors.black.withAlpha(50))
                ],
                borderRadius: BorderRadius.circular(12),
                color: iconWhiteColor,
                image: DecorationImage(
                    image: FileImage(
                        videoImage == null ? image.file : File(videoImage!)),
                    fit: BoxFit.cover),
              ),
              child: GestureDetector(
                onTap: () {
                  orderController.selectedDuelProofs.removeAt(index);
                },
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: SvgPicture.asset(
                    'assets/icons/close_icon.svg',
                    color: selectiveYellowColor,
                    width: 8,
                    height: 8,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _openFileExplorer() async {
    List<PlatformFile> paths = [];
    try {
      paths = (await FilePicker.platform.pickFiles(
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4'],
      ))!
          .files;
      for (final file in paths) {
        final fileSize = file.size;
        final extension = file.extension?.toLowerCase();
        if (extension == 'jpg' || extension == 'png') {
          if (fileSize > 5 * 1024 * 1024) {
            Helpers.toast('Image ${file.name} exceeds 5MB limit');
            continue;
          }
        } else if (extension == 'mp4') {
          if (fileSize > 100 * 1024 * 1024) {
            Helpers.toast('Video ${file.name} exceeds 100MB limit');
            continue;
          }
        }
        orderController.selectedDuelProofs.add(SelectedFile(
            file: File(file.path!),
            fileType: Helpers.getFileType(file.extension!)));
      }
      // for (final i in paths) {
      //   orderController.selectedDuelProofs.add(SelectedFile(
      //       file: File(i.path!), fileType: Helpers.getFileType(i.extension!)));
      // }
    } on PlatformException catch (e) {
      Helpers.toast('Unsupported operation$e');
    } catch (e) {
      Helpers.toast('Something went wrong');
    }
  }
}
