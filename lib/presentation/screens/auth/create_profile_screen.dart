import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/text_fields/auto_complete_field.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/custom_chips.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/input_text_title_widget.dart';
import '../../widgets/input_text_widget.dart';
import '../main/main_screen.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);
  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool visible = false;

  // DateTime selectedDate = DateTime.now() ;
  DateTime? selectedDate;

  var customFormat = DateFormat('dd-MM-yyyy');

  List<String> myProducts = ['Coach', 'Streamer', 'e-Athlete', 'Shout Caster'];
  List<String> productsResult = [];
  List<String> selectedProducts = [];
  TextEditingController selectedProfileTag = TextEditingController();

  Future<Null> showPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: body(),
    );
  }

  Widget body() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Container(
        color: limedAshColor,
        child: Container(
          margin: EdgeInsets.only(top: 44.0),
          decoration: const BoxDecoration(
              color: backgroundBalticSeaColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(31.5, 16.00, 31.5, 16.00),
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Your Basic Details',
                            style: textTheme.headline2
                                ?.copyWith(color: textWhiteColor)),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    _buildRow(textTheme),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const Divider(
                      thickness: 1.2,
                      color: dividerColor,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Full Name',
                        titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const InputTextWidget(
                      hintName: 'Ex: Jhon Singh',
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Display Name',
                        titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const InputTextWidget(
                      hintName: 'Ex: Commander',
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Country',
                        titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const MyDropDownWidget(),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'City', titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    const MyDropDownWidget(),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Date Of Birth',
                        titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    selectDate(textTheme),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Profile Tag',
                        titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 47.0,
                        minWidth: double.infinity,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: textFieldColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Wrap(
                          spacing: 13.0,
                          runSpacing: 0.0,
                          children: List.from(
                            selectedProducts.map((products) {
                              return CustomChips(
                                  chipName: products,
                                  removeItem: () {
                                    setState(() {
                                      final index = selectedProducts.indexWhere((element) => element == products);
                                      selectedProducts.removeAt(index);
                                    });
                                  });
                            }).toList(),
                          )),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    _buildSearchField(textTheme),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    const InputTextTitleWidget(
                        titleName: 'Bio', titleTextColor: textInputTitleColor),
                    SizedBox(
                      width: double.infinity,
                      height: 2.h,
                    ),
                    _buildBioNameField(textTheme),
                    SizedBox(
                      width: double.infinity,
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomButton(
                        color: purpleLightIndigoColor,
                        textColor: textWhiteColor,
                        name: "Update Profile",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MainScreen()));
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
        ),
      ),
    );
  }

  Widget _buildSearchField(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 45,
          minWidth: 45,
        ),
        decoration: BoxDecoration(
          color: textFieldColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.13,
              child: SvgPicture.asset(
                'assets/icons/search_icon.svg',
                color: iconWhiteColor,
                width: 18,
                height: 18,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: AutoCompleteField(
                height: 45,
                selectedSuggestion: selectedProfileTag,
                hint: 'Search Tag',
                icon: 'assets/icons/search.svg',
                suggestionsCallback: (pattern) async {
                  productsResult = myProducts
                      .where((suggestion) => suggestion
                          .toString()
                          .toLowerCase()
                          .contains(pattern.toLowerCase()))
                      .toList();

                  // List finalList = [];
                  // for (int i = 0; i < productsResult.length; i++) {
                  //   finalList.add(productsResult[i].product.name);
                  // }
                  return productsResult;
                },
                onSuggestionSelected: (value) {
                  setState(() {
                    final index = productsResult
                        .indexWhere((element) => element == value);
                    if (selectedProducts
                        .toString()
                        .toLowerCase()
                        .contains('name: ${value.toLowerCase()}')) {
                      if (kDebugMode) print('do nothing');
                    } else {
                      selectedProducts.add(productsResult[index]);
                    }
                  });
                  selectedProfileTag.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(TextTheme textTheme) {
    return Row(
      children: <Widget>[
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage("assets/icons/app_icon.png"),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(aquaGreenColor),
                      ),
                      onPressed: () {
                        debugPrint("change");
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                        child: Text("Change Avatar", style: textTheme.button),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            style: BorderStyle.solid,
                            color: carminePinkColor,
                            width: 1.0,
                          ),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(textFieldColor),
                      ),
                      onPressed: () {
                        debugPrint('clicked');
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                        child: Text("Remove Avatar",
                            style:
                                textTheme.button?.copyWith(color: whiteColor)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildBioNameField(TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: TextFormField(
          style: textTheme.headline4?.copyWith(color: whiteColor),
          maxLines: 4,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle:
                textTheme.headline4?.copyWith(color: textInputTitleColor),
            hintText: 'Ex: Jhon Singh',
          ),
        ),
      ),
    );
  }

  void _goToMainScreen(BuildContext context, TextTheme textTheme) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  selectDate(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        showPicker(context);
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 45,
          minWidth: 45,
        ),
        decoration: BoxDecoration(
          color: textFieldColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              child: Text(
                selectedDate == null
                    ? 'Select DOB'
                    : customFormat.format(selectedDate!),
                style:
                    textTheme.headline4?.copyWith(color: textInputTitleColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
