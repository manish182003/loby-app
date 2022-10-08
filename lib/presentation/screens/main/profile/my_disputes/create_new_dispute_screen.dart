import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../../widgets/body_padding_widget.dart';
import '../../../../widgets/buttons/custom_button.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/input_text_widget.dart';
import '../../../../widgets/text_fields/text_field_widget.dart';
import 'dispute_widget.dart';

class CreateNewDispute extends StatefulWidget {
  final int disputeId;
  const CreateNewDispute({Key? key, required this.disputeId}) : super(key: key);

  @override
  State<CreateNewDispute> createState() => _CreateNewDisputeState();
}

class _CreateNewDisputeState extends State<CreateNewDispute> {

  OrderController orderController = Get.find<OrderController>();

  List<PlatformFile> _paths = [];
  List<String?> selectedFilesExtensions = [];
  TextEditingController fileLink = TextEditingController();
  TextEditingController comments = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dispute = orderController.disputes.where((e) => e.id == widget.disputeId).toList().first;
    return Scaffold(
      appBar: appBar(context: context, appBarName: "My Disputes"),
      body: SingleChildScrollView(
        child: BodyPaddingWidget(
          child: Column(
            children: [
              DisputeWidget(
                  disputeType: "Open",
                  currentStatus: '',
                  dispute: dispute,
              ),
              const SizedBox(height: 16.0),
              _buildUploadField(textTheme),
              const SizedBox(height: 16.0),
              TextFieldWidget(
                textEditingController: comments,
                hint: "Write your comments",
                maxLines: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.h),
                child: CustomButton(
                  color: aquaGreenColor,
                  name: "Submit",
                  textColor: textCharcoalBlueColor,
                  onTap: () async {
                    Helpers.loader();
                    final isSuccess = await orderController.submitDisputeProof(disputeId: widget.disputeId, description: comments.text);
                    Helpers.hideLoader();
                    if(isSuccess){
                      Helpers.toast("dispute successfully created");
                      Navigator.pop(context);
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
                  style: textTheme.headline4?.copyWith(color: textWhiteColor)),
              SizedBox(height: 3.h),
              Obx(() {
                if(orderController.files.isEmpty){
                  return const SizedBox();
                }else{
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          index: index
                      );
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
                  style: textTheme.headline4?.copyWith(color: textWhiteColor)),
              SizedBox(height: 1.h),
              InputTextWidget(
                textAlign: TextAlign.center,
                hintName: 'Paste Youtube/Twitch/Drive Link',
                txtHintColor: whiteColor,
                keyboardType: TextInputType.name,
                controller: fileLink,
              ),
              SizedBox(height: 4.h),
            ],
          )),
    );
  }


  Widget selectedFileTile({required File image, required int index}) {
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
        image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
      ),
      child: GestureDetector(
        onTap: () {
          orderController.files.removeAt(index);
          orderController.fileTypes.removeAt(index);
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
  }


  void _openFileExplorer() async {
    // if (_paths.isNotEmpty) _paths.clear();
    try {
      _paths = (await FilePicker.platform.pickFiles(
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4'],
      ))!.files;

      orderController.files.addAll(_paths);
      selectedFilesExtensions = _paths.map((e) => e.extension).toList();

      for (final i in selectedFilesExtensions) {
        orderController.fileTypes.add(Helpers.getFileType(i!));
      }
    } on PlatformException catch (e) {
      Helpers.toast('Unsupported operation$e');
    } catch (e) {
      Helpers.toast('Something went wrong');
    }
    if (!mounted) return;
  }

}
