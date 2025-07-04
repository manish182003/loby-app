import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/listing/game_category_service_option.dart';
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
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../core/theme/colors.dart';
import '../../../widgets/bottom_dialog.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../../widgets/text_fields/text_field_widget.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  HomeController homeController = Get.find<HomeController>();
  AuthController authController = Get.find<AuthController>();
  ListingController listingController = Get.find<ListingController>();

  bool showErrorMessage = false;

  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  String selectedCategoryName = '';
  int selectedCategoryId = 0;

  TextEditingController selectedGameName = TextEditingController();
  String selectedGameString = '';
  int selectedGameId = 0;
  String selectedUnitName = '';

  List<PlatformFile> _paths = [];
  List<String?> selectedFilesExtensions = [];
  TextEditingController fileLink = TextEditingController();

  List<List<SelectedServiceOption>> multiSelectionServices = [];
  List<SelectedServiceOption> singleSelectionService = [];
  List<TextEditingController> singleSelectedServiceController =
      <TextEditingController>[];

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
    homeController.selectedCategoryId.value = 0;
    homeController.selectedGameId.value = 0;
    listingController.clearListing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // logger.i(
    //     'time->${listingController.configuration.maximumEstimatedDeliveryTimeDays}');
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: BodyPaddingWidget(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Create New Listing',
                  overflow: TextOverflow.ellipsis,
                  style:
                      textTheme.displayMedium?.copyWith(color: aquaGreenColor),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(() {
                return BuildDropdown(
                  selectedValue: selectedCategoryName,
                  dropdownHint: "Select Category",
                  isRequired: true,
                  itemsList: homeController.categories
                      .map((item) => DropdownMenuItem<Category>(
                            value: item,
                            child: Text(item.name!,
                                style: textTheme.displaySmall
                                    ?.copyWith(color: whiteColor)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    listingController.configuration.gameCategoryServices
                        ?.clear();
                    listingController.isServicesAvailable.value = false;
                    multiSelectionServices.clear();
                    singleSelectedServiceController.clear();
                    listingController.optionAnswer.clear();
                    selectedCategoryName = value.name;
                    homeController.selectedCategoryId.value = value.id;
                    homeController.disclaimer.value = value.disclaimer;
                    _getConfigurations();
                  },
                );
              }),
              SizedBox(
                height: 2.h,
              ),
              Obx(() {
                if (homeController.disclaimer.value.isEmpty) {
                  return const SizedBox();
                } else {
                  return DefaultTextHeightBehavior(
                    textHeightBehavior: const TextHeightBehavior(
                      // textHeight: 1.2, // Adjust the text height as needed (1.0 is the default)
                      leadingDistribution: TextLeadingDistribution
                          .proportional, // You can use proportional or uniform
                      // leading: 1.2, // Adjust the line spacing as needed (1.0 is the default)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        Text(
                            textAlign: TextAlign.start,
                            "Disclaimer",
                            style: textTheme.headlineMedium
                                ?.copyWith(color: textWhiteColor)),
                        SizedBox(height: 2.h),
                        StyledText(
                          text: homeController.disclaimer.value,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w300,
                            color: textLightColor,
                          ),
                          tags: {
                            'bold': StyledTextTag(
                                style: textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: textLightColor)),
                            'click': StyledTextActionTag(
                              (text, attrs) {
                                print('data->181');
                                print(attrs.values);
                                BottomDialog(
                                        textTheme: textTheme,
                                        tileName: text,
                                        titleColor: aquaGreenColor,
                                        // contentName: attrs['href'],
                                        contentName: attrs.values.first,
                                        contentLinkName: '')
                                    .showBottomDialog(context);
                              },
                              style: textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: aquaGreenColor),
                            ),
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  );
                }
              }),
              AutoCompleteField(
                selectedSuggestion: selectedGameName,
                hint: 'Select Game',
                isRequired: true,
                suggestionsCallback: (pattern) async {
                  if (pattern == selectedGameString) {
                    await homeController.getGames(name: '');
                  } else {
                    await homeController.getGames(name: pattern);
                  }
                  List finalList = [];
                  for (int i = 0; i < homeController.games.length; i++) {
                    finalList.add(homeController.games[i].name);
                  }
                  return finalList;
                },
                onSuggestionSelected: (value) {
                  listingController.configuration.gameCategoryServices?.clear();
                  listingController.isServicesAvailable.value = false;
                  multiSelectionServices.clear();
                  singleSelectedServiceController.clear();
                  listingController.optionAnswer.clear();
                  final index = homeController.games
                      .indexWhere((element) => element.name == value);
                  homeController.selectedGameId.value =
                      homeController.games[index].id!;
                  selectedGameName.text = homeController.games[index].name!;
                  selectedGameString = homeController.games[index].name!;
                  _getConfigurations();
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(() {
                if (listingController.isServicesAvailable.value) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        itemCount: listingController
                            .configuration.gameCategoryServices!.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 0),
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return services2(index);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 2.h,
                          );
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
                isRequired: true,
              ),
              SizedBox(height: 2.h),
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          "For safety reasons, sellers are not allowed to leave their personal contacts. All communications with the buyers can only be made using Loby chat. Any conversation outside Loby Chat will not be insured/covered by ",
                      style:
                          textTheme.titleLarge?.copyWith(color: textLightColor),
                    ),
                    TextSpan(
                        text: "Loby Protection",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.pushNamed(staticContentPage,
                              extra: {'termName': 'Loby Protection'}),
                        style: textTheme.titleLarge
                            ?.copyWith(color: aquaGreenColor)),
                  ])),
              SizedBox(height: 2.h),
              TextFieldWidget(
                textEditingController: listingController.description.value,
                title: "Description",
                hint: "Type Description",
                maxLines: 5,
                isRequired: true,
                textInputAction: TextInputAction.newline,
              ),
              SizedBox(height: 2.h),
              _buildUploadField(textTheme),
              SizedBox(height: 2.h),
              Text('Price',
                  style: textTheme.headlineMedium
                      ?.copyWith(color: textLightColor)),
              SizedBox(height: 2.h),
              _buildPrice(textTheme),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Text('Available Stock',
                      style: textTheme.headlineMedium
                          ?.copyWith(color: textLightColor)),
                  SizedBox(
                    width: 18.w,
                  ),
                  Expanded(
                    child: TextFieldWidget(
                      textEditingController: listingController.stockAvl.value,
                      // hint: 'Available Stock',
                      type: 'stock',
                      isNumber: true,
                      isRequired: true,
                    ),
                  ),
                ],
              ),
              // TextFieldWidget(
              //   textEditingController: listingController.stockAvl.value,
              //   hint: 'Available Stock',
              //   type: 'stock',
              //   isNumber: true,
              //   isRequired: true,
              // ),
              SizedBox(height: 2.h),
              // RichText(
              //     textAlign: TextAlign.center,
              //     text: TextSpan(children: [
              //       TextSpan(
              //         text: "‘Loby Protection’",
              //         recognizer: TapGestureRecognizer()
              //           ..onTap = () => context.pushNamed(staticContentPage,
              //               extra: {'termName': 'Loby Protection'}),
              //         style:
              //             textTheme.headline4?.copyWith(color: aquaGreenColor),
              //       ),
              //       TextSpan(
              //           text: " Insurance",
              //           style: textTheme.headline4
              //               ?.copyWith(color: textLightColor)),
              //     ])),

              SizedBox(height: 2.h),
              Row(
                children: [
                  Text(
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      'Estimated Delivery \nTime (Days)',
                      style: textTheme.headlineMedium
                          ?.copyWith(color: textLightColor)),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: BuildDropdown(
                      selectedValue:
                          listingController.estimateDeliveryTime.value,
                      dropdownHint: "Select",
                      isRequired: true,
                      itemsList: [
                        for (var i = 1;
                            i <=
                                int.tryParse(listingController.configuration
                                            .maximumEstimatedDeliveryTimeDays ==
                                        ""
                                    ? '0'
                                    : listingController.configuration
                                            .maximumEstimatedDeliveryTimeDays ??
                                        '0')!;
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
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),
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
                                text: "‘Loby Protection’",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => context.pushNamed(
                                      staticContentPage,
                                      extra: {'termName': 'Loby Protection'}),
                                style: textTheme.headlineMedium?.copyWith(
                                  color: aquaGreenColor,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                  text: " Insurance",
                                  style: textTheme.headlineMedium?.copyWith(
                                    color: textLightColor,
                                    fontSize: 12,
                                  )),
                              // TextSpan(
                              //   text: '7 Days Insurance',
                              //   style: textTheme.subtitle2
                              //       ?.copyWith(color: textLightColor),
                              // ),
                            ]))),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              _buildTermsCheckbox(
                  textTheme,
                  'I have read and agreed to all sellers policy and the ',
                  'Terms of Service.'),
              SizedBox(height: showErrorMessage ? 1.h : 0),
              showErrorMessage
                  ? Text(
                      'Please accept the terms of use and privacy policy to proceed...',
                      style:
                          textTheme.headlineSmall?.copyWith(color: Colors.red))
                  : const SizedBox(),
              SizedBox(height: 5.h),
              CustomButton(
                color: createProfileButtonColor,
                name: "Publish",
                textColor: textWhiteColor,
                left: 15.w,
                right: 15.w,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if (isChecked != true) {
                      setState(() => showErrorMessage = true);
                    } else {
                      setState(() => showErrorMessage = false);
                      await _createListing(textTheme);
                    }
                  }
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getConfigurations() async {
    if (homeController.selectedCategoryId.value != 0 &&
        homeController.selectedGameId.value != 0) {
      Helpers.loader();

      multiSelectionServices.clear();
      singleSelectionService.clear();
      singleSelectedServiceController.clear();

      await listingController.getConfigurations(
          categoryId: homeController.selectedCategoryId.value,
          gameId: homeController.selectedGameId.value);
      await homeController.getStaticData();
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
      setState(() {});
      Helpers.hideLoader();
    }
  }

  Future<void> _createListing(TextTheme textTheme) async {
    Helpers.loader();

    listingController.serviceOptionId.clear();

    listingController.serviceOptionId.addAll(singleSelectionService);
    for (final item in multiSelectionServices) {
      listingController.serviceOptionId.addAll(item);
    }

    debugPrint("final service selection ${listingController.serviceOptionId}");

    final isSuccess = await listingController.createListing(
        categoryId: homeController.selectedCategoryId.value,
        gameId: homeController.selectedGameId.value);

    Helpers.hideLoader();
    if (isSuccess) {
      selectedCategoryName = '';
      selectedCategoryId = 0;
      selectedGameName.clear();
      selectedGameString = '';
      selectedGameId = 0;
      selectedUnitName = '';

      BottomDialog(
          textTheme: textTheme,
          tileName: "Congratulations",
          titleColor: aquaGreenColor,
          contentName:
              "Your service has been successfully listed. You can edit your listings from My Listings.",
          contentLinkName: ' My Listings',
          onOk: () {
            Navigator.pop(context);
            context.pushNamed(myListingPage);
          }).showBottomDialog(context);
    }
  }

  void _openFileExplorer() async {
    try {
      // final permissionStatus = await Permission.storage.status;
      // if (permissionStatus.isDenied) {
      //   // Here just ask for the permission for the first time
      //   await Permission.storage.request();

      //   // I noticed that sometimes popup won't show after user press deny
      //   // so I do the check once again but now go straight to appSettings
      //   if (permissionStatus.isDenied) {
      //     await openAppSettings();
      //   }
      // } else if (permissionStatus.isPermanentlyDenied) {
      //   // Here open app settings for user to manually enable permission in case
      //   // where permission was permanently denied
      //   await openAppSettings();
      // } else {
      //   // Do stuff that require permission here
      //   _paths = (await FilePicker.platform.pickFiles(
      //   allowMultiple: true,
      //   onFileLoading: (FilePickerStatus status) => print(status),
      //   type: FileType.custom,
      //   allowedExtensions: ['jpg', 'png', 'mp4'],
      // ))!
      //     .files;

      // listingController.files.addAll(_paths);
      // selectedFilesExtensions = _paths.map((e) => e.extension).toList();

      // for (final i in selectedFilesExtensions) {
      //   listingController.fileTypes.add(Helpers.getFileType(i!));
      // }
      // }

      _paths = (await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowCompression: true,
        compressionQuality: 60,
        onFileLoading: (FilePickerStatus status) {
          if (status == FilePickerStatus.picking) {}
        },
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
        listingController.files.add(file);
        selectedFilesExtensions.add(extension);
        listingController.fileTypes.add(Helpers.getFileType(extension!));
      }

      // listingController.files.addAll(_paths);

      // selectedFilesExtensions = _paths.map((e) => e.extension).toList();

      // for (final i in selectedFilesExtensions) {
      //   listingController.fileTypes.add(Helpers.getFileType(i!));
      // }
    } on PlatformException catch (e) {
      Helpers.toast('Unsupported operation$e');
    } catch (e) {
      Helpers.toast('Something went wrong');
    }
    if (!mounted) return;
  }

  Widget services2(int index) {
    final textTheme = Theme.of(context).textTheme;
    final service =
        listingController.configuration.gameCategoryServices![index].service;
    final serviceOption = listingController
        .configuration.gameCategoryServices![index].gameCategoryServiceOptions;

    switch (service?.selectionType) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: multiSelectionServices[service.index].isNotEmpty ? 2.h : 0.h,),
            BuildDropdown(
              dropdownHint: service!.name,
              isMultiple: true,
              isRequired: true,
              selectedItemList: multiSelectionServices[service.index],
              itemsList: serviceOption
                  ?.map((item) => DropdownMenuItem<GameCategoryServiceOption>(
                        value: item,
                        child: Text(item.serviceOption!.serviceOptionName!,
                            style: textTheme.displaySmall
                                ?.copyWith(color: whiteColor)),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  final index2 = serviceOption?.indexWhere((element) =>
                      element.serviceOption?.serviceOptionName ==
                      value.serviceOption.serviceOptionName);

                  print(multiSelectionServices[service.index]);
                  print(value);

                  if (multiSelectionServices[service.index]
                      .map((e) => e.name)
                      .contains(value.serviceOption.serviceOptionName)) {
                    debugPrint('do nothing');
                  } else {
                    multiSelectionServices[service.index]
                        .add(SelectedServiceOption(
                      id: serviceOption?[index2!].serviceOption?.id,
                      name: serviceOption?[index2!]
                          .serviceOption
                          ?.serviceOptionName,
                    ));

                    debugPrint(
                        "Multi Selection Array ${multiSelectionServices[service.index]}");
                  }
                });
              },
            ),
            multiSelectionServices[service.index].isEmpty
                ? const SizedBox()
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        color: textFieldColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0))),
                    child: Wrap(
                      spacing: 12.0,
                      runSpacing: 0.0,
                      children: List.from(
                        multiSelectionServices[service.index].map((services) {
                          return CustomChips(
                              chipName: services.name,
                              removeItem: () {
                                setState(() {
                                  multiSelectionServices[service.index]
                                      .removeWhere((element) =>
                                          element.name == services.name);
                                });
                              });
                        }).toList(),
                      ),
                    ),
                  ),
            // AutoCompleteField(
            //   hint: service.name,
            //   isMultiple: true,
            //   isRequired: true,
            //   selectedValuesList: multiSelectionServices[service.index],
            //   suggestionsCallback: (pattern) async {
            //     final result = serviceOption?.where((suggestion) => suggestion.toString().toLowerCase().contains(pattern.toLowerCase())).toList();
            //     List finalList = [];
            //     for (int i = 0; i < result!.length; i++) {
            //       finalList.add(result[i].serviceOption?.serviceOptionName);
            //     }
            //     return finalList;
            //   },
            //   onSuggestionSelected: (value) {
            //     setState(() {
            //
            //       final index2 = serviceOption?.indexWhere((element) => element.serviceOption?.serviceOptionName == value);
            //
            //       print(multiSelectionServices[service.index]);
            //       print(value);
            //
            //       if (multiSelectionServices[service.index].toString().contains(value)) {
            //         debugPrint('do nothing');
            //       } else {
            //         multiSelectionServices[service.index].add(SelectedServiceOption(
            //           id: serviceOption?[index2!].serviceOption?.id,
            //           name: serviceOption?[index2!].serviceOption?.serviceOptionName,
            //         ));
            //
            //         debugPrint("Multi Selection Array ${multiSelectionServices[service.index]}");
            //       }
            //     });
            //   },
            // ),
          ],
        );

      case 1:
        return BuildDropdown(
          dropdownHint: service!.name,
          selectedValue: singleSelectedServiceController[service.index].text,
          isMultiple: false,
          isRequired: true,
          itemsList: serviceOption
              ?.map((item) => DropdownMenuItem<GameCategoryServiceOption>(
                    value: item,
                    child: Text(item.serviceOption?.serviceOptionName ?? '',
                        style: textTheme.displaySmall
                            ?.copyWith(color: whiteColor)),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              final index2 = serviceOption?.indexWhere((element) =>
                  element.serviceOption?.serviceOptionName ==
                  value.serviceOption.serviceOptionName);
              singleSelectedServiceController[service.index].text =
                  serviceOption![index2!].serviceOption!.serviceOptionName!;
              singleSelectionService[service.index].name =
                  serviceOption[index2].serviceOption?.serviceOptionName;
              singleSelectionService[service.index].id =
                  serviceOption[index2].serviceOption?.id;
            });
            debugPrint(
                "Single Selection Array ${singleSelectionService[service.index]}");
          },
        );

      // AutoCompleteField(
      //     hint: service!.name,
      //     selectedSuggestion: singleSelectedServiceController[service.index],
      //     isMultiple: false,
      //     isRequired: true,
      //     suggestionsCallback: (pattern) async {
      //       final result = serviceOption?.where((suggestion) =>
      //           suggestion.toString().toLowerCase().contains(
      //               pattern.toLowerCase())).toList();
      //       List finalList = [];
      //       for (int i = 0; i < result!.length; i++) {
      //         finalList.add(result[i].serviceOption?.serviceOptionName);
      //       }
      //       return finalList;
      //     },
      //     onSuggestionSelected: (value) {
      //       setState(() {
      //         final index2 = serviceOption?.indexWhere((element) => element.serviceOption?.serviceOptionName == value);
      //         singleSelectedServiceController[service.index].text = serviceOption![index2!].serviceOption!.serviceOptionName!;
      //         singleSelectionService[service.index].name = serviceOption[index2].serviceOption?.serviceOptionName;
      //         singleSelectionService[service.index].id = serviceOption[index2].serviceOption?.id;
      //       });
      //       debugPrint("Single Selection Array ${singleSelectionService[service.index]}");
      //     },
      //   );

      case 2:
        return TextFieldWidget(
          textEditingController: listingController.optionAnswer[service!.index],
          hint: service.name!,
          isRequired: true,
        );

      default:
        return const SizedBox();
    }
  }

  Widget selectedFileTile({
    required File image,
    required int index,
  }) {
    //  for (var path in _paths) {
    //     if (path.extension == 'mp4') {
    //       var thumb = await VideoThumbnail.thumbnailFile(
    //         video: path.path!,
    //         imageFormat: ImageFormat.PNG,

    //       );
    //       if (thumb != null) {
    //         final file = File(thumb);
    //         listingController.files.add(PlatformFile(
    //           name: file.uri.pathSegments.last,
    //           path: file.path,
    //           size: await file.length(),
    //         ));

    //       }
    //     }
    //   }
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
                        listingController.files.removeAt(index);
                        listingController.fileTypes.removeAt(index);
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
                      listingController.files.removeAt(index);
                      listingController.fileTypes.removeAt(index);
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
  }

  _buildTermsCheckbox(TextTheme textTheme, String content, String textSpan) {
    return Padding(
      padding: const EdgeInsets.only(right: 60),
      child: Row(
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
                        style: textTheme.titleSmall?.copyWith(
                          color: textWhiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                          text: textSpan,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.pushNamed(staticContentPage,
                                extra: {'termName': 'Terms of Use'}),
                          style: textTheme.titleSmall?.copyWith(
                            color: aquaGreenColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          )),
                    ]))),
          ),
        ],
      ),
    );
  }

  _buildPrice(TextTheme textTheme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/token.png",
              height: 20,
              width: 20,
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: TextFieldWidget(
                textEditingController: listingController.price.value,
                hint: "Enter Price",
                type: "token",
                isNumber: true,
                isRequired: true,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    listingController.tokenToRupee.value =
                        (int.tryParse(value)! *
                                int.tryParse(
                                    homeController.staticData[5].realValue!)!)
                            .floor()
                            .toString();
                    listingController
                        .rupeeToToken.value = (int.tryParse(value)! /
                            int.tryParse(homeController.staticData[5].key!)!)
                        .floor()
                        .toString();
                  } else {
                    listingController.tokenToRupee.value = '0';
                    listingController.rupeeToToken.value = '0';
                  }
                },
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              "per",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: textTheme.headlineMedium
                  ?.copyWith(fontSize: 13.0, color: textLightColor),
            ),
            SizedBox(width: 2.w),
            Expanded(
                child: BuildDropdown(
              selectedValue: selectedUnitName,
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
                selectedUnitName = value.name;
                listingController.priceUnitId.value = value.id;
                debugPrint("unit id ${listingController.priceUnitId.value}");
              },
            )),
          ],
        ),
        SizedBox(height: 2.h),
        // Container(
        //   padding: const EdgeInsets.all(6.0),
        //   // margin: const EdgeInsets.symmetric(horizontal: 15.0),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: textErrorColor, width: 1),
        //     borderRadius: BorderRadius.circular(8.0),
        //   ),
        //   child: Obx(() {
        //     return Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         TokenWidget(
        //           tokens: listingController.rupeeToToken.value,
        //           textColor: whiteColor,
        //           size: 20,
        //         ),
        //         Text(
        //           " = ₹ ${listingController.tokenToRupee}",
        //           style: textTheme.displaySmall?.copyWith(color: whiteColor),
        //         ),
        //       ],
        //     );
        //   }),
        // )
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
              SizedBox(height: 2.h),
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
}
