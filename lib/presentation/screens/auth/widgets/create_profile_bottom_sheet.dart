import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/auth/selected_option.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/widgets/body_padding_widget.dart';
import 'package:loby/presentation/widgets/custom_chips.dart';
import 'package:loby/presentation/widgets/text_fields/text_field_widget.dart';
import 'package:loby/services/routing_service/routes.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/colors.dart';
import '../../../widgets/text_fields/auto_complete_field.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/input_text_title_widget.dart';
import '../../../widgets/input_text_widget.dart';
import '../../main/main_screen.dart';

class CreateProfileCard extends StatefulWidget {
  final String from;
  const CreateProfileCard({Key? key, required this.from}) : super(key: key);


  @override
  State<CreateProfileCard> createState() => _CreateProfileCardState();
}

class _CreateProfileCardState extends State<CreateProfileCard> {

  AuthController authController = Get.find<AuthController>();
  ProfileController profileController = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController selectedProfileTag = TextEditingController();
  final _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BodyPaddingWidget(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Your Basic Details',
                        style: textTheme.headline2?.copyWith(
                            color: textWhiteColor)),
                  ],
                ),
                SizedBox(height: 2.h,),
                _buildRow(textTheme),
                const Divider(
                  thickness: 1.2,
                  color: dividerColor,
                ),
                SizedBox(height: 2.h,),
                TextFieldWidget(
                  textEditingController: authController.fullName.value,
                  title: "Full Name",
                  hint: "Ex: John Doe",
                  isRequired: true,
                ),
                SizedBox(height: 3.h,),
                TextFieldWidget(
                  textEditingController: authController.displayName.value,
                  title: "Display Name",
                  hint: "Ex: Commander",
                  isRequired: true,
                  onChanged: (value){
                    authController.usernameString.value = value;
                    if(value.isNotEmpty){
                      authController.checkUsername(value);
                    }
                  },
                ),
                SizedBox(height: 1.h,),
                Obx(() {
                  if(authController.usernameString.value.isEmpty){
                    return const SizedBox();
                  }else{
                    return Text(authController.isUsernameAvailable.value ? "Yayy... Username Available" : "Oops... Username Not Available",
                      style: textTheme.headline6?.copyWith(color: authController.isUsernameAvailable.value ? aquaGreenColor : textErrorColor),);
                  }
                }),
                SizedBox(height: 3.h,),
                AutoCompleteField(
                  selectedSuggestion: TextEditingController(text: authController.selectedCountry.value.name),
                  hint: 'Select Countries',
                  title: 'Country',
                  suggestionsCallback: (pattern) async {
                    await authController.getCountries(search: pattern);
                    List finalList = [];
                    for (int i = 0; i < authController.countries.length; i++) {
                      finalList.add(authController.countries[i].name);
                    }
                    return finalList;
                  },
                  onSuggestionSelected: (value) {
                    setState(() {
                      final index = authController.countries.indexWhere((element) => element.name == value);
                      authController.selectedCountry.value = SelectedOption(id: authController.countries[index].id!, name: authController.countries[index].name!);
                      print(authController.selectedCountry.value);
                    });
                  },
                ),
                SizedBox(height: 3.h,),
                AutoCompleteField(
                  selectedSuggestion: TextEditingController(text: authController.selectedState.value.name),
                  hint: 'Select State',
                  title: 'State',
                  suggestionsCallback: (pattern) async {
                    await authController.getStates(search: pattern, countryId: authController.selectedCountry.value.id);
                    List finalList = [];
                    for (int i = 0; i < authController.states.length; i++) {
                      finalList.add(authController.states[i].name);
                    }
                    return finalList;
                  },
                  onSuggestionSelected: (value) {
                    setState(() {
                      final index = authController.states.indexWhere((element) => element.name == value);
                      authController.selectedState.value = SelectedOption(id: authController.states[index].id!, name: authController.states[index].name!);
                      print(authController.selectedState.value);
                    });
                  },
                ),

                SizedBox(height: 3.h,),
                AutoCompleteField(
                  selectedSuggestion: TextEditingController(text: authController.selectedCity.value.name),
                  hint: 'Select City',
                  title: 'City',
                  suggestionsCallback: (pattern) async {
                    await authController.getCities(search: pattern, stateId: authController.selectedState.value.id);
                    List finalList = [];
                    for (int i = 0; i < authController.cities.length; i++) {
                      finalList.add(authController.cities[i].name);
                    }
                    return finalList;
                  },
                  onSuggestionSelected: (value) {
                    setState(() {
                      final index = authController.cities.indexWhere((element) => element.name == value);
                      authController.selectedCity.value = SelectedOption(id: authController.cities[index].id!, name: authController.cities[index].name!);
                      print(authController.selectedCity.value);
                    });
                  },
                ),
                SizedBox(height: 3.h,),
                TextFieldWidget(
                  textEditingController: authController.DOB.value,
                  type: "date",
                  title: "Date Of Birth",
                  hint: "Select DOB",
                  isRequired: true,
                ),
                SizedBox(height: 3.h,),
                Obx(() {
                  if (authController.selectedProfileTags.isEmpty) {
                    return const SizedBox();
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Wrap(
                          spacing: 13.0,
                          runSpacing: 0.0,
                          children: List.from(
                            authController.selectedProfileTags.map((products) {
                              return CustomChips(
                                  chipName: products['name'],
                                  removeItem: () {
                                    setState(() {
                                      final index = authController.selectedProfileTags.indexWhere((element) => element == products);
                                      authController.selectedProfileTags.removeAt(index);
                                    });
                                  });
                            }).toList(),
                          )),
                    );
                  }
                }),
                AutoCompleteField(
                  selectedSuggestion: selectedProfileTag,
                  title: 'Profile Tag',
                  hint: 'Search Tag',
                  icon: 'assets/icons/search.svg',
                  isMultiple: true,
                  suggestionsCallback: (pattern) async {
                    await authController.getProfileTags(search: pattern);

                    List finalList = [];
                    for (int i = 0; i <
                        authController.profileTags.length; i++) {
                      finalList.add(authController.profileTags[i].name);
                    }
                    return finalList;
                  },
                  onSuggestionSelected: (value) {
                    setState(() {
                      final index = authController.profileTags.indexWhere((element) => element.name == value);
                      if (authController.selectedProfileTags.toString().toLowerCase().contains('name: ${value.toLowerCase()}')) {
                        if (kDebugMode) print('do nothing');
                      } else {
                        authController.selectedProfileTags.add({
                          'name': authController.profileTags[index].name,
                          'id': authController.profileTags[index].id
                        });
                        print(authController.selectedProfileTags);
                      }
                    });
                  },
                ),
                SizedBox(height: 3.h,),
                TextFieldWidget(
                  textEditingController: authController.bio.value,
                  title: "Bio",
                  hint: "Ex: John Doe",
                  isRequired: true,
                ),
                SizedBox(height: 3.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomButton(
                    color: purpleLightIndigoColor,
                    textColor: textWhiteColor,
                    name: "Update Profile",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await Helpers.loader();
                        final isSuccess = await authController.updateProfile();
                        await Helpers.hideLoader();
                        if (isSuccess) {
                          if(widget.from == 'signIn'){
                            Navigator.pop(context);
                            context.goNamed(mainPage);
                          }else{
                            await profileController.getProfile();
                            Navigator.pop(context);
                          }
                        }
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 4.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(TextTheme textTheme) {
    return SizedBox(
      height: 28.h,
      child: Stack(
        children: [
          showCoverImage(textTheme),
          Positioned.fill(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: showProfileImage(textTheme)
            ),
          ),
        ],
      ),
    );
  }


  _imgFromGallery(String type) async {
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        if(type == 'cover'){
          authController.coverImageFile.value = File(image.path);
        }else{
          authController.profileImageFile.value = File(image.path);
        }
      } else {
        if (kDebugMode) print('No image selected.');
      }
    });
  }

  _imgFromCamera(String type) async {
    var image = await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (image != null) {
        if(type == 'cover'){
          authController.coverImageFile.value = File(image.path);
        }else{
          authController.profileImageFile.value = File(image.path);
        }
      } else {
        if (kDebugMode) print('No image selected.');
      }
    });
  }


  Widget showProfileImage(TextTheme textTheme) {
    return GestureDetector(
      onTap: (){
        Helpers.showImagePicker(context: context,
            onCamera: (){
              _imgFromCamera('profile');
            },
            onGallery: (){
              _imgFromGallery('profile');
            });

      },
      child: Stack(
        children: [
          authController.profileImageFile.value.path.isNotEmpty ?
          Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: aquaGreenColor),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(authController.profileImageFile.value, fit: BoxFit.cover,)),
              )
          ) : Padding(padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 100,
                width: 100,
                decoration:  BoxDecoration(
                  color: const Color(0xffCDDDDF),
                  border: Border.all(width: 2.0, color: aquaGreenColor),
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_a_photo, color: Color(0xff337077),
                      size: 25,),
                    Text('Image', style: textTheme.headline4?.copyWith(fontSize: 14))
                  ],),
              )),
          Positioned(bottom: 10, right: 0, left: 60, height: 35,
              child: GestureDetector(
                onTap: () {
                  Helpers.showImagePicker(context: context,
                      onCamera: (){
                        _imgFromCamera('profile');
                      },
                      onGallery: (){
                        _imgFromGallery('profile');
                      });
                },
                child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: aquaGreenColor,
                    child: Icon(
                      Icons.add_a_photo, color: Colors.white,
                      size: 16,)
                ),
              ))
        ],
      ),
    );
  }

  Widget showCoverImage(TextTheme textTheme) {
    return GestureDetector(
      onTap: (){
        Helpers.showImagePicker(
            context: context,
            onCamera: (){
              _imgFromCamera('cover');
            },
            onGallery: (){
              _imgFromGallery('cover');
            }
        );
      },
      child: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: authController.coverImageFile.value.path.isNotEmpty ?
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black45.withOpacity(0.3),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(authController.coverImageFile.value, fit: BoxFit.cover,)),
                )
            ) : Padding(padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffCDDDDF),
                    // shape: BoxShape.rectangle,
                    borderRadius:  BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_a_photo, color: Color(0xff337077),
                        size: 25,),
                      Text('Upload Cover Image', style: textTheme.headline4?.copyWith(fontSize: 14))
                    ],),
                )),
          ),
          Positioned(bottom: 2.h, right: 0, left: 70.w, height: 35,
              child: GestureDetector(
                onTap: () {
                  Helpers.showImagePicker(context: context,
                      onCamera: (){
                        _imgFromCamera('profile');
                      },
                      onGallery: (){
                        _imgFromGallery('profile');
                      });
                },
                child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: aquaGreenColor,
                    child: Icon(
                      Icons.add_a_photo, color: Colors.white,
                      size: 16,)

                ),
              ))
        ],
      ),
    );
  }
}
