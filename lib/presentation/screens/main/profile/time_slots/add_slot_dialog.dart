import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/slots_controller.dart';
import 'package:loby/services/routing_service/routes_name.dart';
import 'package:sizer/sizer.dart';

class AddSlotDialog extends StatefulWidget {
  final int selectedDayIndex;
  const AddSlotDialog({super.key, required this.selectedDayIndex});

  @override
  State<AddSlotDialog> createState() => _AddSlotDialogState();
}

class _AddSlotDialogState extends State<AddSlotDialog> {
  SlotsController slotController = Get.find<SlotsController>();
  AuthController authController = Get.find<AuthController>();

  // TimeOfDay _selectedTime = TimeOfDay.now();

  // TimeOfDay? _selectedFromTime;
  // TimeOfDay? _selectedToTime;
  // TimeOfDay _selectedFromTime = TimeOfDay.now();
  // Future<void> _selectFromTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedFromTime,
  //     // use24HourFormat: false,
  //   );
  //   if (picked != null && picked != _selectedFromTime) {
  //     setState(() {
  //       _selectedFromTime = picked;
  //     });
  //   }
  // }

  Future<void> _selectFromTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      DateTime selectedTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );
      String formattedTime = DateFormat.jm().format(selectedTime);
      setState(() {
        slotController.fromTime.value.text = formattedTime;
      });
    }
  }

// String _convertTo24HourFormat(String time) {
//     DateTime dateTime = DateFormat.jm().parse(time);
//     return DateFormat.Hm().format(dateTime);
//   }

//   void _sendFromDataToAPI() {
//     // Get the time from the text field in 12-hour format
//     String timeIn12HourFormat = slotController.fromTime.value.text;

//     // Convert the time to 24-hour format for sending to the API
//     String timeIn24HourFormat = _convertTo24HourFormat(timeIn12HourFormat);

//     // Send data to API with time in 24-hour format
//     print("Sending time to API: $timeIn24HourFormat");
//     // Your API call logic goes here
//   }

//   void _sendToDataToAPI() {
//     // Get the time from the text field in 12-hour format
//     String timeIn12HourFormat = slotController.toTime.value.text;

//     // Convert the time to 24-hour format for sending to the API
//     String timeIn24HourFormat = _convertTo24HourFormat(timeIn12HourFormat);

//     // Send data to API with time in 24-hour format
//     print("Sending time to API: $timeIn24HourFormat");
//     // Your API call logic goes here
//   }

  Future<void> _selectToTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      DateTime selectedTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );
      String formattedTime = DateFormat.jm().format(selectedTime);
      setState(() {
        slotController.toTime.value.text = formattedTime;
      });
    }
  }

  // Future<void> _selectFromTimePick(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedFromTime ?? TimeOfDay.now(),
  //   );

  //   if (picked != null && picked != _selectedFromTime) {
  //     setState(() {
  //       _selectedFromTime = picked;
  //       slotController.fromTime.value.text = _selectedFromTime!.format(context);

  //       if (_selectedToTime != null &&
  //               _selectedFromTime!.hour > _selectedToTime!.hour ||
  //           (_selectedFromTime!.hour == _selectedToTime!.hour &&
  //               _selectedFromTime!.minute > _selectedToTime!.minute)) {
  //         _selectedToTime = null;
  //         slotController.toTime.value.text = "";
  //       }
  //     });
  //   }
  // }

  // Future<void> _selectToTimePick(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedToTime ?? TimeOfDay.now(),
  //   );

  //   if (picked != null && picked != _selectedToTime) {
  //     setState(() {
  //       _selectedToTime = picked;
  //       slotController.toTime.value.text = _selectedToTime!.format(context);
  //     });
  //   }
  // }

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
                          style: textTheme.displaySmall
                              ?.copyWith(color: textErrorColor)),
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          slotController
                              .addSlots(
                                  from: slotController.sendFromDataToAPI(),
                                  to: slotController.sendToDataToAPI(),
                                  // sellerId: 104,
                                  day: slotController.days
                                      .indexOf(slotController.selectedDay[0]))
                              .then((value) {
                            Navigator.of(context).pop();
                            context.pushNamed(sellerTimeSlotScreen);
                          });
                        } else if (!_formKey.currentState!.validate()) {
                          // Helpers.toast("Please fill details");
                        }
                      },
                      child: Text("Save",
                          style: textTheme.displaySmall
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
                          style: textTheme.headlineMedium?.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w300)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: slotController.fromTime.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter start time';
                            }
                            return null;
                          },
                          onTap: () {
                            _selectFromTime(context);
                          },
                          readOnly: true,
                          textAlign: TextAlign.center,
                          style: textTheme.displayMedium
                              ?.copyWith(color: textWhiteColor),
                          decoration: const InputDecoration(
                              hintText: "00:00 AM",
                              hintStyle:
                                  TextStyle(color: textCharcoalBlueColor),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: aquaGreenColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: aquaGreenColor)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
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
                          style: textTheme.headlineMedium?.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w300)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: slotController.toTime.value,
                          readOnly: true,
                          onTap: () {
                            _selectToTime(context);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter End time';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          style: textTheme.displayMedium
                              ?.copyWith(color: textWhiteColor),
                          decoration: const InputDecoration(
                              // suffixIcon: IconButton(
                              //   icon: Icon(Icons.access_time),
                              //   onPressed: () => _selectToTimePick(context),
                              // ),
                              hintText: "00:00 AM",
                              hintStyle:
                                  TextStyle(color: textCharcoalBlueColor),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: aquaGreenColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: aquaGreenColor)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none)
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
