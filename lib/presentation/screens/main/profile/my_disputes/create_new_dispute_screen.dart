import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/widgets/carousel.dart';
import 'package:sizer/sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../../widgets/body_padding_widget.dart';
import '../../../../widgets/buttons/custom_button.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_loader.dart';
import '../../../../widgets/text_fields/text_field_widget.dart';
import 'dispute_widget.dart';

class CreateNewDispute extends StatefulWidget {
  final int disputeId;

  const CreateNewDispute({super.key, required this.disputeId});

  @override
  State<CreateNewDispute> createState() => _CreateNewDisputeState();
}

class _CreateNewDisputeState extends State<CreateNewDispute> {
  OrderController orderController = Get.find<OrderController>();

  List<PlatformFile> _paths = [];
  List<String?> selectedFilesExtensions = [];
  TextEditingController fileLink = TextEditingController();
  TextEditingController comments = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool fetching = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      orderController.areMoreDisputesAvailable.value = true;
      await orderController.getDisputes(id: widget.disputeId);
      setState(() {
        fetching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar:
          appBar(context: context, appBarName: "My Disputes", isBackIcon: true),
      body: Obx(() {
        if (orderController.isDisputesFetching.value || fetching) {
          return const CustomLoader();
        } else {
          final dispute = orderController.disputes
              .where((e) => e.id == widget.disputeId)
              .toList()
              .first;
          return SingleChildScrollView(
            child: BodyPaddingWidget(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    dispute.disputeProofs!.isEmpty
                        ? const SizedBox()
                        : Carousel(
                            images: [
                              for (final i in dispute.disputeProofs!)
                                CarouselList(
                                    type: i.fileType!, path: i.filePath!)
                            ],
                          ),
                    dispute.disputeProofs!.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            height: 2.h,
                          ),
                    DisputeWidget(
                      disputeType: "Open",
                      currentStatus: '',
                      dispute: dispute,
                    ),
                    const SizedBox(height: 16.0),
                    dispute.result == 'RESOLVED'
                        ? const SizedBox()
                        : _buildUploadField(textTheme),
                    dispute.result == 'RESOLVED'
                        ? const SizedBox()
                        : const SizedBox(height: 16.0),
                    dispute.result == 'RESOLVED'
                        ? const SizedBox()
                        : TextFieldWidget(
                            textEditingController: comments,
                            hint: "Write your comments",
                            maxLines: 5,
                            isRequired: true,
                          ),
                    dispute.result == 'RESOLVED'
                        ? const SizedBox()
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10.h),
                            child: CustomButton(
                              color: aquaGreenColor,
                              name: "Submit",
                              textColor: textCharcoalBlueColor,
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  Helpers.loader();
                                  final isSuccess =
                                      await orderController.submitDisputeProof(
                                          disputeId: widget.disputeId,
                                          description: comments.text,
                                          link: fileLink.text);
                                  Helpers.hideLoader();
                                  if (isSuccess) {
                                    Helpers.toast(
                                        "Dispute Proof Successfully Submitted");
                                    Navigator.pop(context);
                                  }
                                }
                              },
                            ),
                          ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  _buildUploadField(TextTheme textTheme) {
    return DottedBorder(
      color: iconTintColor,
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      strokeWidth: 1,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            color: textFieldColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              Text(
                  textAlign: TextAlign.center,
                  "Upload Images or Videos",
                  style: textTheme.headlineMedium
                      ?.copyWith(color: textWhiteColor)),
              SizedBox(height: 3.h),
              Obx(() {
                if (orderController.files.isEmpty) {
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
                    itemCount: orderController.files.length,
                    itemBuilder: (context, index) {
                      return selectedFileTile(
                          image: File(orderController.files[index].path!),
                          index: index);
                    },
                  );
                }
              }),
              CustomButton(
                top: 0.h,
                left: 15.w,
                right: 15.w,
                bottom: 1.h,
                color: createProfileButtonColor,
                name: "Choose file",
                textColor: textWhiteColor,
                iconWidget: 'assets/icons/upload_img_icon.svg',
                onTap: () {
                  _openFileExplorer();
                },
              ),
              SizedBox(height: 2.h),
              Text("or",
                  style: textTheme.headlineMedium
                      ?.copyWith(color: textWhiteColor)),
              SizedBox(height: 1.h),
              TextFieldWidget(
                textEditingController: fileLink,
                hint: 'Paste Link of Proofs Uploaded',
                type: 'optionalLink',
                isRequired: true,
              ),
              SizedBox(height: 4.h),
            ],
          )),
    );
  }

  // Widget selectedFileTile({required File image, required int index}) {
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
  //       image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
  //     ),
  //     child: GestureDetector(
  //       onTap: () {
  //         orderController.files.removeAt(index);
  //         orderController.fileTypes.removeAt(index);
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

  Widget selectedFileTile({required File image, required int index}) {
    return StatefulBuilder(
      builder: (context, setState) {
        String? videoImage;
        bool isLoading = false;
        Rx<double> loadingValue = 0.0.obs;

        return FutureBuilder<String?>(
          future: () async {
            if (image.path.toLowerCase().endsWith('.mp4')) {
              isLoading = true;

              return await VideoThumbnail.thumbnailFile(
                video: image.path,
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
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 6, top: 6),
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
                          valueColor:
                              AlwaysStoppedAnimation<Color>(aquaGreenColor),
                          value: loadingValue.value,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        orderController.files.removeAt(index);
                        orderController.fileTypes.removeAt(index);
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0xFFE94F31),
                        radius: 8,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/close_icon.svg',
                            color: textWhiteColor,
                            width: 5,
                            height: 5,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            videoImage = snapshot.data;
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.only(right: 6, top: 6),
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
                            videoImage == null ? image : File(videoImage!)),
                        fit: BoxFit.cover),
                  ),
                  // child: GestureDetector(
                  //   onTap: () {
                  //     listingController.files.removeAt(index);
                  //     listingController.fileTypes.removeAt(index);
                  //   },
                  //   child: Align(
                  //     alignment: AlignmentDirectional.topEnd,
                  //     child: SvgPicture.asset(
                  //       'assets/icons/close_icon.svg',
                  //       color: selectiveYellowColor,
                  //       width: 8,
                  //       height: 8,
                  //     ),
                  //   ),
                  // ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      orderController.files.removeAt(index);
                      orderController.fileTypes.removeAt(index);
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFE94F31),
                      radius: 8,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/close_icon.svg',
                          color: textWhiteColor,
                          width: 5,
                          height: 5,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );

    //  StatefulBuilder(
    //   builder: (context, setState) {
    //     String? videoImage;
    //     bool isLoading = false;
    //     Rx<double> loadingValue = 0.0.obs;

    //     return FutureBuilder<String?>(
    //       future: () async {
    //         if (image.path.toLowerCase().endsWith('.mp4')) {
    //           isLoading = true;

    //           return await VideoThumbnail.thumbnailFile(
    //             video: image.path,
    //             imageFormat: ImageFormat.PNG,
    //           );
    //         } else {
    //           return null;
    //         }
    //       }(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting &&
    //             snapshot.data == null) {
    //           Timer.periodic(
    //             Duration(milliseconds: 100),
    //             (timer) {
    //               if (loadingValue.value < 1) {
    //                 loadingValue.value += 0.1;
    //               } else {
    //                 timer.cancel();
    //               }
    //             },
    //           );
    //           return Container(
    //             padding: const EdgeInsets.all(8),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(12),
    //               color: iconWhiteColor,
    //             ),
    //             child: Align(
    //               alignment: Alignment.bottomCenter,
    //               child: Obx(
    //                 () => LinearProgressIndicator(
    //                   borderRadius: BorderRadius.circular(8),
    //                   minHeight: 5,
    //                   valueColor: AlwaysStoppedAnimation<Color>(aquaGreenColor),
    //                   value: loadingValue.value,
    //                 ),
    //               ),
    //             ),
    //           );
    //         }
    //         videoImage = snapshot.data;
    //         return Container(
    //           padding: const EdgeInsets.all(8),
    //           constraints: BoxConstraints(
    //               minHeight: MediaQuery.of(context).size.height * 0.08,
    //               minWidth: MediaQuery.of(context).size.width * 0.4),
    //           decoration: BoxDecoration(
    //             boxShadow: [
    //               BoxShadow(
    //                   spreadRadius: 1,
    //                   blurRadius: 5,
    //                   color: Colors.black.withAlpha(50))
    //             ],
    //             borderRadius: BorderRadius.circular(12),
    //             color: iconWhiteColor,
    //             image: DecorationImage(
    //                 image: FileImage(
    //                     videoImage == null ? image : File(videoImage!)),
    //                 fit: BoxFit.cover),
    //           ),
    //           child: GestureDetector(
    //             onTap: () {
    //               orderController.files.removeAt(index);
    //               orderController.fileTypes.removeAt(index);
    //             },
    //             child: Align(
    //               alignment: AlignmentDirectional.topEnd,
    //               child: SvgPicture.asset(
    //                 'assets/icons/close_icon.svg',
    //                 color: selectiveYellowColor,
    //                 width: 8,
    //                 height: 8,
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
  }

  void _openFileExplorer() async {
    // if (_paths.isNotEmpty) _paths.clear();
    try {
      _paths = (await FilePicker.platform.pickFiles(
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4'],
      ))!
          .files;

      for (final file in _paths) {
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
        // Add valid files only
        orderController.files.add(file);
        selectedFilesExtensions.add(extension);
        orderController.fileTypes.add(Helpers.getFileType(extension!));
      }

      // orderController.files.addAll(_paths);
      // selectedFilesExtensions = _paths.map((e) => e.extension).toList();

      // for (final i in selectedFilesExtensions) {
      //   orderController.fileTypes.add(Helpers.getFileType(i!));
      // }
    } on PlatformException catch (e) {
      Helpers.toast('Unsupported operation$e');
    } catch (e) {
      Helpers.toast('Something went wrong');
    }
    if (!mounted) return;
  }
}
