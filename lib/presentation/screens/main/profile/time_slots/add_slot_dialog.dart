import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/slots_controller.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

class AddSlotDialog extends StatefulWidget {
  final int selectedDayIndex;
  AddSlotDialog({super.key, required this.selectedDayIndex});

  @override
  State<AddSlotDialog> createState() => _AddSlotDialogState();
}

class _AddSlotDialogState extends State<AddSlotDialog> {
  SlotsController slotController = Get.find<SlotsController>();
  AuthController authController = Get.find<AuthController>();

  // TimeOfDay _selectedTime = TimeOfDay.now();

  TimeOfDay? _selectedFromTime;
TimeOfDay? _selectedToTime;

  Future<void> _selectFromTimePick(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedFromTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedFromTime) {
      setState(() {
        _selectedFromTime = picked;
        slotController.fromTime.value.text = _selectedFromTime!.format(context);

        if (_selectedToTime != null &&
          _selectedFromTime!.hour > _selectedToTime!.hour ||
          (_selectedFromTime!.hour == _selectedToTime!.hour &&
          _selectedFromTime!.minute > _selectedToTime!.minute)) {
        _selectedToTime = null;
        slotController.toTime.value.text = "";
      }
      });
    }
  }

  Future<void> _selectToTimePick(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedToTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedToTime) {
      setState(() {
        _selectedToTime = picked;
        slotController.toTime.value.text = _selectedToTime!.format(context);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      elevation: 0,
      backgroundColor: backgroundDarkJungleGreenColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: SizedBox(
        height: 46.h,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pushNamed(sellerTimeSlotScreen);
                      },
                      child: Text("Cancel",
                          style: textTheme.headline3
                              ?.copyWith(color: textErrorColor)),
                    ),
                    InkWell(
                      onTap: () {
                        slotController
                            .addSlots(
                                from: slotController.fromTime.value.text,
                                to: slotController.toTime.value.text,
                                sellerId: 104,
                                day: slotController.days
                                    .indexOf(slotController.selectedDay[0]))
                            .then((value) {
                          context.pushNamed(sellerTimeSlotScreen);
                        });
                        if (_formKey.currentState!.validate()) {
                          // slotController
                          //     .addSlots(
                          //         sellerId: 104,
                          //         day: slotController.days
                          //             .indexOf(slotController.selectedDay[0]))
                          //     .then((value) {
                          //   context.pop();
                          // });
                        } else if (!_formKey.currentState!.validate()) {
                          // Helpers.toast("")
                        }
                      },
                      child: Text("Save",
                          style: textTheme.headline3
                              ?.copyWith(color: aquaGreenColor)),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Start Time",
                          style: textTheme.headline4?.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w300)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          controller: slotController.fromTime.value,
                          onTap: () {
                            _selectFromTimePick(context);
                          },
                          readOnly: true,
                          textAlign: TextAlign.center,
                          style: textTheme.headline2
                              ?.copyWith(color: textWhiteColor),
                          decoration: InputDecoration(
                            hintText: "00:00 AM",
                            hintStyle: TextStyle(color: textCharcoalBlueColor),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: aquaGreenColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: aquaGreenColor)),
                            // suffixIcon: IconButton(
                            //   icon: Icon(Icons.access_time),
                            //   onPressed: () => _selectFromTimePick(context),
                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("End Time",
                          style: textTheme.headline4?.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w300)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          controller: slotController.toTime.value,
                          // readOnly: true,
                          onTap: () {
                            _selectToTimePick(context);
                          },
                          textAlign: TextAlign.center,
                          style: textTheme.headline2
                              ?.copyWith(color: textWhiteColor),

                          decoration: InputDecoration(
                            // suffixIcon: IconButton(
                            //   icon: Icon(Icons.access_time),
                            //   onPressed: () => _selectToTimePick(context),
                            // ),
                            hintText: "00:00 AM",
                            hintStyle: TextStyle(color: textCharcoalBlueColor),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: aquaGreenColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: aquaGreenColor)),

                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
