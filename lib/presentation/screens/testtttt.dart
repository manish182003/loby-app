import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';

class Tsting extends StatefulWidget {
  const Tsting({Key? key}) : super(key: key);

  @override
  State<Tsting> createState() => _TstingState();
}

class _TstingState extends State<Tsting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<String> strArr = ['hello', 'world'];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: DropdownButtonFormField2(
            customButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Test'),
                SvgPicture.asset(
                  'assets/icons/dropdown.svg',
                  color: textErrorColor,
                ),
              ],
            ),
            decoration: _inputDecoration(textTheme),
            isExpanded: true,
            style: textTheme.headline3?.copyWith(color: profileDropDown),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: profileDropDown,
            ),
            iconSize: 20,
            buttonHeight: 16,
            buttonPadding: const EdgeInsets.only(left: 10, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            items: _addNewBusiness(strArr, textTheme),
            onChanged: (value) async {
              await Container();
            },
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _addNewBusiness(
      List<String> items, TextTheme textTheme) {
    List<DropdownMenuItem<String>> _menuItems = [];

    for (var item in items) {
      _menuItems.addAll(
        [
          if (item == items.first)
            DropdownMenuItem<String>(
                enabled: false,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 1.h),
                    width: MediaQuery.of(context).size.width,
                    height: 8.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      '+ Add New Business',
                      style:
                          textTheme.headline3?.copyWith(color: aquaGreenColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),

          DropdownMenuItem<String>(
            value: item,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                child: ListTile(
                    leading: Text('dwdsds'),
                    trailing: const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 22,
                    ))),
          ),

          //If it's last item, we will not add Divider after it.
          // if (item != items.last)
          //   const DropdownMenuItem<String>(
          //     child: Padding(
          //       padding: EdgeInsets.all(0.0),
          //       child: Divider(color: dividerColor, thickness: 1.2),
          //     ),
          //   ),
        ],
      );
    }
    return _menuItems;
  }

  InputDecoration _inputDecoration(TextTheme textTheme) {
    return InputDecoration(
      label: const Text('Selected Business/Profile'),
      labelStyle: textTheme.headline3?.copyWith(
        color: Colors.black.withOpacity(0.6),
      ),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: aquaGreenColor, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      border: const OutlineInputBorder(
          borderSide: BorderSide(color: profileDropDown, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: profileDropDown, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: profileDropDown, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(4))),
    );
  }
}
