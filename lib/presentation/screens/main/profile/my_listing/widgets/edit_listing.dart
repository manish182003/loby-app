import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/listing/user_game_service_image.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/text_fields/custom_drop_down.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../domain/entities/listing/unit.dart';
import '../../../../../widgets/confirmation_dialog.dart';

class EditListing extends StatefulWidget {
  final ServiceListing listing;

  const EditListing({Key? key, required this.listing}) : super(key: key);

  @override
  State<EditListing> createState() => _EditListingState();
}

class _EditListingState extends State<EditListing> {
  final _formKey = GlobalKey<FormState>();
  ListingController listingController = Get.find<ListingController>();
  HomeController homeController = Get.find<HomeController>();
  List<PlatformFile> _paths = [];
  List<String?> selectedFilesExtensions = [];
  TextEditingController fileLink = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListingDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listingController.clearListing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BodyPaddingWidget(
        child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWidget(
              textEditingController:
                  TextEditingController(text: widget.listing.category!.name),
              title: "Category",
              isReadableOnly: true,
            ),
            SizedBox(height: 2.h),
            TextFieldWidget(
              textEditingController:
                  TextEditingController(text: widget.listing.game!.name),
              title: "Game",
              isReadableOnly: true,
            ),
            SizedBox(height: 2.h),
            TextFieldWidget(
              textEditingController: TextEditingController(
                  text: widget.listing.userGameServiceOptions!
                      .map((e) => e.serviceOptions?.first.serviceOptionName)
                      .toList()
                      .join(", ")),
              title: "Service Type",
              isReadableOnly: true,
            ),
            SizedBox(height: 2.h),
            TextFieldWidget(
              textEditingController: listingController.title.value,
              title: "Title",
              hint: "Enter Title",
            ),
            SizedBox(height: 2.h),
            TextFieldWidget(
              textEditingController: listingController.description.value,
              title: "Description",
              hint: "Type Description",
              maxLines: 5,
              textInputAction: TextInputAction.newline,
            ),
            SizedBox(height: 4.h),
            Obx(() {
              if (listingController.downloadedListingFiles.isEmpty) {
                return const SizedBox();
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                  ),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 0),
                  itemCount: listingController.downloadedListingFiles.length,
                  itemBuilder: (context, index) {
                    return downloadedFileTile(
                        image: listingController.downloadedListingFiles[index],
                        index: index);
                  },
                );
              }
            }),
            SizedBox(height: 4.h),
            _buildUploadField(textTheme),
            SizedBox(height: 4.h),
            _buildPrice(textTheme),
            SizedBox(height: 2.h),
            BuildDropdown(
              defaultValue: listingController.configuration.units
                  ?.where((element) =>
                      element.id == listingController.priceUnitId.value)
                  .first,
              dropdownHint: "Select Unit",
              isRequired: true,
              itemsList: listingController.configuration.units
                  ?.map((item) => DropdownMenuItem<Unit>(
                        value: item,
                        child: Text(item.name!,
                            style: textTheme.displaySmall
                                ?.copyWith(color: whiteColor)),
                      ))
                  .toList(),
              onChanged: (value) {
                listingController.priceUnitId.value = value.id;
                debugPrint("unit id ${listingController.priceUnitId.value}");
              },
            ),
            SizedBox(height: 2.h),
            Text(
                textAlign: TextAlign.start,
                'Estimated Delivery Time (Days)',
                style:
                    textTheme.headlineMedium?.copyWith(color: textLightColor)),
            SizedBox(height: 2.h),
            BuildDropdown(
              defaultValue: listingController.estimateDeliveryTime.value,
              dropdownHint: "Select",
              isRequired: true,
              itemsList: [
                for (var i = 1;
                    i <=
                        int.tryParse(widget.listing.category?.edtDays == ""
                            ? '0'
                            : widget.listing.category?.edtDays ?? '0')!;
                    i++)
                  i
              ]
                  .map((item) => DropdownMenuItem<String>(
                        value: "$item",
                        child: Text("$item",
                            style: textTheme.displaySmall
                                ?.copyWith(color: whiteColor)),
                      ))
                  .toList(),
              onChanged: (value) {
                listingController.estimateDeliveryTime.value = value;
                debugPrint(
                    "edt ${listingController.estimateDeliveryTime.value}");
              },
            ),
            SizedBox(height: 4.h),
            CustomButton(
              color: createProfileButtonColor,
              name: "Publish",
              textColor: textWhiteColor,
              left: 15.w,
              right: 15.w,
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  Helpers.loader();
                  final isSuccess = await listingController.createListing(
                      listingId: widget.listing.id);
                  Helpers.hideLoader();
                  if (isSuccess) {
                    listingController.buyerListingPageNumber.value = 1;
                    listingController.areMoreListingAvailable.value = true;
                    listingController.getBuyerListings(from: 'myProfile');
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> getListingDetails() async {
    listingController.title.value.text = widget.listing.title!;
    listingController.description.value.text = widget.listing.description!;
    listingController.price.value.text = "${widget.listing.price!}";
    listingController.stockAvl.value.text = "${widget.listing.stockAvl!}";
    listingController.downloadedListingFiles.value =
        widget.listing.userGameServiceImages!;
    listingController.estimateDeliveryTime.value =
        widget.listing.edt.toString();
    listingController.priceUnitId.value = widget.listing.priceUnitId!;
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
              spreadRadius: 1, blurRadius: 5, color: Colors.black.withAlpha(50))
        ],
        borderRadius: BorderRadius.circular(12),
        color: iconWhiteColor,
        image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
      ),
      child: GestureDetector(
        onTap: () {
          listingController.files.removeAt(index);
          listingController.fileTypes.removeAt(index);
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

  Widget downloadedFileTile(
      {required UserGameServiceImage image, required int index}) {
    return Container(
      padding: const EdgeInsets.all(8),
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.08,
          minWidth: MediaQuery.of(context).size.width * 0.4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              spreadRadius: 1, blurRadius: 5, color: Colors.black.withAlpha(50))
        ],
        borderRadius: BorderRadius.circular(12),
        color: iconWhiteColor,
        image: DecorationImage(
            image: NetworkImage(image.path!), fit: BoxFit.cover),
      ),
      child: GestureDetector(
        onTap: () {
          final textTheme = Theme.of(context).textTheme;

          ConfirmationBottomDialog(
              textTheme: textTheme,
              contentName: "Are you sure you want delete this image ?",
              yesBtnClick: () async {
                Helpers.loader();
                final isSuccess = await listingController.deleteListingImage(
                    id: image.id!, path: image.path!);
                Helpers.hideLoader();
                if (isSuccess) {
                  listingController.downloadedListingFiles.removeAt(index);
                  Helpers.toast("Image Successfully Deleted");
                  Navigator.pop(context);
                }
              }).showBottomDialog(context);
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

  _buildPrice(TextTheme textTheme) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3.h),
          child: Image.asset(
            "assets/images/token.png",
            height: 20,
            width: 20,
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        Expanded(
          child: TextFieldWidget(
            textEditingController: listingController.price.value,
            title: 'Token',
            type: "token",
            hint: "",
            isNumber: true,
            isRequired: true,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        Expanded(
          child: TextFieldWidget(
            textEditingController: listingController.stockAvl.value,
            title: "Stock Available",
            hint: 'Available Stock',
            type: 'stock',
            isNumber: true,
            isRequired: true,
          ),
        ),
      ],
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
                if (listingController.files.isEmpty) {
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
                    itemCount: listingController.files.length,
                    itemBuilder: (context, index) {
                      return selectedFileTile(
                          image: File(listingController.files[index].path!),
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
                  onTap: _openFileExplorer),
              Text("or",
                  style: textTheme.headlineMedium
                      ?.copyWith(color: textWhiteColor)),
              SizedBox(height: 1.h),
              TextFieldWidget(
                textEditingController: listingController.filePathLink.value,
                hint: 'Paste Youtube/Twitch/Drive Link',
                type: 'optionalLink',
                isRequired: true,
              ),
              SizedBox(height: 4.h),
            ],
          )),
    );
  }

  void _openFileExplorer() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4'],
      ))!
          .files;

      listingController.files.addAll(_paths);
      selectedFilesExtensions = _paths.map((e) => e.extension).toList();

      for (final i in selectedFilesExtensions) {
        listingController.fileTypes.add(Helpers.getFileType(i!));
      }
    } on PlatformException catch (e) {
      Helpers.toast('Unsupported operation$e');
    } catch (e) {
      Helpers.toast('Something went wrong');
    }
    if (!mounted) return;
  }
}
