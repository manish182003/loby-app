import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/listing/selected_service_option.dart';
import 'package:loby/domain/entities/listing/unit.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/home_controller.dart';
import 'package:loby/presentation/getx/controllers/listing_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_chips.dart';
import 'package:loby/presentation/widgets/text_fields/auto_complete_field.dart';
import 'package:loby/presentation/widgets/text_fields/custom_drop_down.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';
import 'package:styled_text/styled_text.dart';
import '../../../../core/theme/colors.dart';
import '../../../widgets/bottom_dialog_widget.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/input_text_title_widget.dart';
import '../../../widgets/input_text_widget.dart';
import '../../../widgets/text_fields/text_field_widget.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({Key? key}) : super(key: key);

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {

  HomeController homeController = Get.find<HomeController>();
  AuthController authController = Get.find<AuthController>();
  ListingController listingController = Get.find<ListingController>();

  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  String selectedCategoryName = '';
  int selectedCategoryId = 0;

  TextEditingController selectedGameName = TextEditingController();
  int selectedGameId = 0;
  String selectedUnitName = '';

  List<PlatformFile> _paths = [];
  List<String?> selectedFilesExtensions = [];
  TextEditingController fileLink = TextEditingController();

  List<List<SelectedServiceOption>> multiSelectionServices = [];
  List<SelectedServiceOption> singleSelectionService = [];
  List<TextEditingController> singleSelectedServiceController = <TextEditingController>[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getCategories();
    });
  }

  @override
  void dispose() {
    listingController.isServicesAvailable.value = false;
    homeController.disclaimer.value = "";
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: BodyPaddingWidget(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Create New Listing',
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headline2?.copyWith(color: textWhiteColor),
                  ),
                ),
                SizedBox(height: 2.h,),
                Obx(() {
                  return BuildDropdown(
                    selectedValue: selectedCategoryName,
                    dropdownHint: "Select Category",
                    itemsList: homeController.categories.map((item) =>
                        DropdownMenuItem<Category>(
                          value: item,
                          child: Text(
                              item.name!,
                              style: textTheme.headline3?.copyWith(color: whiteColor)
                          ),
                        )).toList(),
                    onChanged: (value) {
                      selectedCategoryName = value.name;
                      homeController.selectedCategoryId.value = value.id;
                      homeController.disclaimer.value = value.disclaimer;
                    },
                  );
                }),
                SizedBox(height: 2.h,),
                Obx(() {
                  if(homeController.disclaimer.value.isEmpty){
                    return const SizedBox();
                  }else{
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        Text(textAlign: TextAlign.start, "Disclaimer",
                            style: textTheme.headline4?.copyWith(color: textWhiteColor)),
                        SizedBox(height: 2.h),
                        StyledText(
                          text: homeController.disclaimer.value, style: textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: textLightColor,
                        ),
                          tags:  {
                            'bold': StyledTextTag(style: textTheme.headline6!.copyWith(fontWeight: FontWeight.w500, color: textLightColor)),
                            'click': StyledTextActionTag((text, attrs) {
                                    BottomDialog(
                                        textTheme: textTheme,
                                        tileName: text,
                                        titleColor: aquaGreenColor,
                                        contentName: attrs['href'],
                                        contentLinkName: '')
                                        .showBottomDialog(context);
                                  },
                              style: textTheme.headline6!.copyWith(fontWeight: FontWeight.w500, color: aquaGreenColor),
                            ),
                          },
                        ),
                        SizedBox(height: 2.h,),
                      ],
                    );
                  }
                }),
                AutoCompleteField(
                  selectedSuggestion: selectedGameName,
                  hint: 'Select Game',
                  suggestionsCallback: (pattern) async {
                    await homeController.getGames(name: pattern);
                    List finalList = [];
                    for (int i = 0; i < homeController.games.length; i++) {
                      finalList.add(homeController.games[i].name);
                    }
                    return finalList;
                  },
                  onSuggestionSelected: (value) async {

                    Helpers.loader();

                    final index = homeController.games.indexWhere((element) => element.name == value);
                    homeController.selectedGameId.value = homeController.games[index].id!;
                    selectedGameName.text = homeController.games[index].name!;
                    await listingController.getConfigurations(
                        categoryId: homeController.selectedCategoryId.value,
                        gameId: homeController.selectedGameId.value
                    );
                    int multiFieldsCount = 0;
                    int singleFieldsCount = 0;
                    int openFieldsCount = 0;

                    for (final i in listingController.configuration.gameCategoryServices!) {
                      switch (i.service?.selectionType) {
                        case 0:
                          i.service?.index = multiFieldsCount;
                          multiFieldsCount += 1;
                          multiSelectionServices.add(<SelectedServiceOption>[]);
                          break;
                        case 1:
                          i.service?.index = singleFieldsCount;
                          singleFieldsCount += 1;
                          singleSelectionService.add(SelectedServiceOption());
                          singleSelectedServiceController.add(TextEditingController());
                          break;
                        case 2:
                          i.service?.index = openFieldsCount;
                          openFieldsCount += 1;
                          listingController.optionAnswer.add(TextEditingController());
                          break;
                      }
                    }
                    listingController.isServicesAvailable.value = true;
                    Helpers.hideLoader();
                  },
                ),
                SizedBox(height: 2.h,),
                Obx(() {
                  if (listingController.isServicesAvailable.value) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ListView.separated(
                          itemCount: listingController.configuration.gameCategoryServices!.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 0),
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return services2(index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 2.h,);
                          },
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                SizedBox(height: 2.h),
                TextFieldWidget(
                  textEditingController: listingController.title.value,
                  title: "Title",
                  hint: "Enter Title",
                ),
                SizedBox(height: 2.h),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "For safety reasons, sellers are not allowed to leave their personal contacts. All communications with the buyers can only be made using Loby chat. Any conversation outside Loby Chat will not be insured/covered by ",
                        style: textTheme.headline6?.copyWith(
                            color: textLightColor),
                      ),
                      TextSpan(
                          text: "Loby Protection",
                          style: textTheme.headline6?.copyWith(
                              color: aquaGreenColor)),
                    ])),
                SizedBox(height: 2.h),
                TextFieldWidget(
                  textEditingController: listingController.description.value,
                  title: "Description",
                  hint: "Type Description",
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                ),
                SizedBox(height: 2.h),
                _buildUploadField(textTheme),
                SizedBox(height: 2.h),
                Text('Price', style: textTheme.headline4?.copyWith(color: textLightColor)),
                SizedBox(height: 2.h),
                _buildPrice(textTheme),
                SizedBox(height: 2.h),
                TextFieldWidget(
                  textEditingController: listingController.stockAvl.value,
                  hint: 'Available Stock',
                  isNumber: true,
                ),
                SizedBox(height: 2.h),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "‘Loby Protection’",
                        style: textTheme.headline4
                            ?.copyWith(color: aquaGreenColor),
                      ),
                      TextSpan(
                          text: " Insurance",
                          style: textTheme.headline4
                              ?.copyWith(color: textLightColor)),
                    ])),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: aquaGreenColor,
                          border: Border.all(color: aquaGreenColor)),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 9.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: SizedBox(
                          child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: '7 Days Insurance',
                                  style: textTheme.subtitle2
                                      ?.copyWith(color: textLightColor),
                                ),
                              ]))),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                    textAlign: TextAlign.start,
                    'Estimated Delivery Time (Days)',
                    style: textTheme.headline4?.copyWith(
                        color: textLightColor)),
                SizedBox(height: 2.h),
                BuildDropdown(
                  selectedValue: listingController.estimateDeliveryTime.value,
                  dropdownHint: "Select",
                  itemsList:  [for(var i = 1; i <= (listingController.configuration.maximumEstimatedDeliveryTimeDays ?? "").length; i++) i].map((item) =>
                      DropdownMenuItem<String>(
                        value: "$item",
                        child: Text("$item",
                            style: textTheme.headline3?.copyWith(
                                color: whiteColor)
                        ),
                      )).toList(),
                  onChanged: (value) {
                    listingController.estimateDeliveryTime.value = value;
                     },
                ),
                SizedBox(height: 2.h),
                _buildTermsCheckbox(
                    textTheme,
                    'I have read and agreed to all sellers policy and the ',
                    'Terms of Service.'),
                SizedBox(height: 5.h),
                CustomButton(
                  color: createProfileButtonColor,
                  name: "Publish",
                  textColor: textWhiteColor,
                  left: 15.w,
                  right: 15.w,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      Helpers.loader();

                      listingController.serviceOptionId.clear();

                      listingController.serviceOptionId.addAll(singleSelectionService);
                      for (final item in multiSelectionServices) {
                        listingController.serviceOptionId.addAll(item);
                      }

                      debugPrint("final service selection ${listingController.serviceOptionId}");


                      final isSuccess = await listingController.createListing(
                          categoryId: homeController.selectedCategoryId.value,
                          gameId: homeController.selectedGameId.value
                      );

                      Helpers.hideLoader();
                      if (isSuccess) {
                        BottomDialog(
                            textTheme: textTheme,
                            tileName: "Congratulations",
                            titleColor: aquaGreenColor,
                            contentName: "Your service has been successfully listed. You can edit your listings from My Listings.",
                            contentLinkName: ' My Listings',
                            onOk: (){
                              Navigator.pop(context);
                              context.pushNamed(myListingPage);
                            })
                            .showBottomDialog(context);
                      }
                    }
                  },
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _openFileExplorer() async {

    try {
      _paths = (await FilePicker.platform.pickFiles(
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4'],
      ))!.files;

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


  Widget services2(int index) {
    final service = listingController.configuration.gameCategoryServices![index].service;
    final serviceOption = listingController.configuration.gameCategoryServices![index].gameCategoryServiceOptions;

    switch (service?.selectionType) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                    spacing: 12.0,
                    runSpacing: 0.0,
                    children: List.from(
                      multiSelectionServices[service!.index].map((services) {
                        return CustomChips(
                            chipName: services.name,
                            removeItem: () {
                              setState((){
                                multiSelectionServices[service.index].removeWhere((element) => element.name == services.name);
                              });
                              }
                        );
                      }).toList(),
                    )
                ),
                AutoCompleteField(
                  hint: service.name,
                  isMultiple: true,
                  suggestionsCallback: (pattern) async {
                    final result = serviceOption?.where((suggestion) => suggestion.toString().toLowerCase().contains(pattern.toLowerCase())).toList();
                    List finalList = [];
                    for (int i = 0; i < result!.length; i++) {
                      finalList.add(result[i].serviceOption?.serviceOptionName);
                    }
                    return finalList;
                  },
                  onSuggestionSelected: (value) {
                    setState(() {

                      final index2 = serviceOption?.indexWhere((element) => element.serviceOption?.serviceOptionName == value);

                      if (multiSelectionServices[service.index].toString().toLowerCase().contains('${value.toLowerCase()}')) {
                        debugPrint('do nothing');
                      } else {
                        multiSelectionServices[service.index].add(SelectedServiceOption(
                          id: serviceOption?[index2!].serviceOption?.id,
                          name: serviceOption?[index2!].serviceOption?.serviceOptionName,
                        ));

                        debugPrint("Multi Selection Array ${multiSelectionServices[service.index]}");
                      }
                    });
                  },
                ),
              ],
            );

      case 1:
        return AutoCompleteField(
              hint: service!.name,
              selectedSuggestion: singleSelectedServiceController[service.index],
              isMultiple: false,
              suggestionsCallback: (pattern) async {
                final result = serviceOption?.where((suggestion) =>
                    suggestion.toString().toLowerCase().contains(
                        pattern.toLowerCase())).toList();
                List finalList = [];
                for (int i = 0; i < result!.length; i++) {
                  finalList.add(result[i].serviceOption?.serviceOptionName);
                }
                return finalList;
              },
              onSuggestionSelected: (value) {
                setState(() {
                  final index2 = serviceOption?.indexWhere((element) => element.serviceOption?.serviceOptionName == value);
                  singleSelectedServiceController[service.index].text = serviceOption![index2!].serviceOption!.serviceOptionName!;
                  singleSelectionService[service.index].name = serviceOption[index2].serviceOption?.serviceOptionName;
                  singleSelectionService[service.index].id = serviceOption[index2].serviceOption?.id;
                });
                debugPrint("Single Selection Array ${singleSelectionService[service.index]}");
              },
            );

      case 2:
        return TextFieldWidget(
          textEditingController: listingController.optionAnswer[service!.index],
          hint: service.name!,
        );

      default:
        return const SizedBox();
    }
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

  _buildTermsCheckbox(TextTheme textTheme, String content, String textSpan) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCheckbox(
          isChecked: isChecked,
          onChange: (value) {
            isChecked = value;
          },
          backgroundColor: aquaGreenColor,
          borderColor: aquaGreenColor,
          icon: Icons.check,
          size: 16,
          iconSize: 10,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: SizedBox(
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(
                      text: content,
                      style:
                      textTheme.subtitle2?.copyWith(color: textLightColor),
                    ),
                    TextSpan(
                        text: textSpan,
                        style: textTheme.subtitle2
                            ?.copyWith(color: aquaGreenColor)),
                  ]))),
        ),
      ],
    );
  }

  _buildPrice(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("₹ ", style: textTheme.headline3?.copyWith(color: textWhiteColor),),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.40,
          child: TextFieldWidget(
            textEditingController: listingController.price.value,
            hint: "",
            isNumber: true,
          ),
        ),
        const SizedBox(width: 2.0),
        Text(
          "per",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: textTheme.headline4
              ?.copyWith(fontSize: 13.0, color: textLightColor),
        ),
        const SizedBox(width: 2.0),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: BuildDropdown(
              selectedValue: selectedUnitName,
              dropdownHint: "Select Unit",
              itemsList: listingController.configuration.units?.map((item) =>
                  DropdownMenuItem<Unit>(
                    value: item,
                    child: Text(
                        item.name!,
                        style: textTheme.headline3?.copyWith(color: whiteColor)
                    ),
                  )).toList(),
              onChanged: (value) {
                selectedUnitName = value.name;
                listingController.priceUnitId.value = value.id;
                debugPrint("unit id ${listingController.priceUnitId.value}");
              },
            )),
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
                  style: textTheme.headline4?.copyWith(color: textWhiteColor)),
              SizedBox(height: 3.h),
              Obx(() {
                if(listingController.files.isEmpty){
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
                    itemCount: listingController.files.length,
                    itemBuilder: (context, index) {
                      return selectedFileTile(
                          image: File(listingController.files[index].path!),
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
                onTap: _openFileExplorer
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
}
