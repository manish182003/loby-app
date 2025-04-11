import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/presentation/getx/controllers/slots_controller.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class MyTimeSlot extends StatefulWidget {
  const MyTimeSlot({super.key});

  @override
  State<MyTimeSlot> createState() => _MyTimeSlotState();
}

class _MyTimeSlotState extends State<MyTimeSlot> {
  SlotsController slotsController = Get.find<SlotsController>();
  List<String> days = ['Monday', 'Friday', 'Sunday'];
  List<Map<String, dynamic>> availableTimeSlots = [
    {
      'startTime': '8:00',
      'endTime': '9:30',
    },
    {
      'startTime': '12:30',
      'endTime': '13:30',
    },
    {
      'startTime': '15:00',
      'endTime': '16:30',
    },
    {
      'startTime': '22:00',
      'endTime': '22:30',
    },
    {
      'startTime': '23:00',
      'endTime': '23:30',
    },
  ];
  List<Map<String, dynamic>> dynamicTimeSlots = [
    {
      "from": from,
      "to": to,
    },
  ];
  static List<String> from = ["8:00", "9:00", "13:00", "16:00"];
  static List<String> to = ["10:00", "12:00", "17:00", "19:00"];
  String? selectedDay;
  List<TextEditingController?> fromTimes = [null];
  List<TextEditingController?> toTimes = [null];

  @override
  void initState() {
    getSlots();
    super.initState();
  }

  Future<void> getSlots() async {
    // slotsController.getSlots();
    slotsController.areMoreSlotsAvailable.value = true;
    slotsController.getSlots();
  }

  void onTap(String day) {
    setState(() {
      dynamicTimeSlots.clear();
      fromTimes.clear();
      toTimes.clear();
      dynamicTimeSlots.insert(
        dynamicTimeSlots.length,
        {
          "from": from,
          "to": to,
        },
      );

      fromTimes.insert(fromTimes.length, TextEditingController());
      toTimes.insert(toTimes.length, TextEditingController());
      if (slotsController.selectedDay.value.contains(day)) {
        // Remove the day if it's already selected
        slotsController.selectedDay.value = '';
      } else {
        // Add the day if it's not selected
        slotsController.selectedDay.value = day;
      }
    });
    // int indexOfDay = days.indexOf(day);
    // selectedDay.add(day);
    // selectedDay
  }

  Future<void> _selectFromTime(BuildContext context, int index) async {
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
        fromTimes[index] = TextEditingController(text: formattedTime);
        // slotsController.fromTime.value.text = formattedTime;
      });
    }
  }

  Future<void> _selectToTime(BuildContext context, int index) async {
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
        toTimes[index] = TextEditingController(text: formattedTime);
        // slotsController.toTime.value.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        appBarName: 'Time Slot',
        txtColor: textWhiteColor,
        isBackIcon: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  // Reduces the dropdowns height by +/- 50%
                  hint: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: Text(
                            'Select Day',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: textLightColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  iconStyleData: IconStyleData(
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: iconWhiteColor,
                      ),
                    ),
                  ),
                  value: slotsController.selectedDay.value.isEmpty
                      ? null
                      : slotsController.selectedDay.value,

                  items: slotsController.days
                      .map(
                        (day) => DropdownMenuItem<String>(
                            value: day,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                      )
                      .toList(),
                  // customItemsIndexes: _getDividersIndexes(),
                  // customItemsHeight: 4,
                  // value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      onTap(value ?? '');
                      slotsController.getSlots();
                      selectedDay = value ?? '';
                    });
                  },

                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: shipGreyColor,
                    ),
                  ),
                  style: TextStyle(
                    color: textWhiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  buttonStyleData: ButtonStyleData(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: shipGreyColor,
                    ),
                  ),
                  // buttonHeight: 40,
                  // buttonWidth: 140,
                  // itemHeight: 40,
                  // itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Time Slots',
                    style: TextStyle(
                      color: aquaGreenColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Divider(
                    color: aquaGreenColor,
                  )
                ],
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Obx(() {
                if (slotsController.slots.isEmpty) {
                  return Center(
                    child: Text(
                      'No Slots Available',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textWhiteColor,
                      ),
                    ),
                  );
                }
                return Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: slotsController.slots.map((slot) {
                    String fromtimeIn24HourFormat = "${slot.from}";
                    DateTime fromtime24Hour =
                        DateFormat('HH:mm').parse(fromtimeIn24HourFormat);
                    String fromtimeIn12HourFormat =
                        DateFormat('h:mm a').format(fromtime24Hour);

                    String totimeIn24HourFormat = "${slot.to}";
                    DateTime totime24Hour =
                        DateFormat('HH:mm').parse(totimeIn24HourFormat);
                    String totimeIn12HourFormat =
                        DateFormat('h:mm a').format(totime24Hour);
                    return Stack(
                      children: [
                        Container(
                          width: 26.w,
                          height: 5.h,
                          margin: EdgeInsets.only(right: 3, top: 5),
                          decoration: BoxDecoration(
                            color: shipGreyColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: '$fromtimeIn12HourFormat - ',
                                      style: TextStyle(
                                        fontSize: 9.5.spa,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  TextSpan(
                                      text: totimeIn12HourFormat,
                                      style: TextStyle(
                                        fontSize: 9.5.spa,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: CircleAvatar(
                            radius: 8,
                            child: GestureDetector(
                              onTap: () async {
                                await slotsController.deleteSlots(
                                    slotId: slot.slotId);
                              },
                              child: Icon(
                                Icons.close,
                                color: textErrorColor,
                                size: 12,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }).toList(),
                );
              }),
              SizedBox(
                height: 4.h,
              ),
              Container(
                width: 30.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Color(0xFFFF754C),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Text(
                    'Copy to all Days',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: textWhiteColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Time Slots',
                    style: TextStyle(
                      color: aquaGreenColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Divider(
                    color: aquaGreenColor,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Column(
                    children: [
                      if (slotsController.selectedDay.isNotEmpty)
                        ...dynamicTimeSlots.asMap().entries.map(
                              (e) => addTimeSlotsDynamically(e.key),
                            )
                      else
                        Center(
                          child: Text(
                            'Select Day',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: textWhiteColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (fromTimes.last != null &&
                            toTimes.last != null &&
                            slotsController.selectedDay.isNotEmpty) {
                          slotsController.fromTime.value.text =
                              fromTimes.last?.text ?? '';
                          slotsController.toTime.value.text =
                              toTimes.last?.text ?? '';
                          final success = await slotsController.addSlots(
                              from: slotsController.sendFromDataToAPI(),
                              to: slotsController.sendToDataToAPI(),
                              // sellerId: 104,
                              day: slotsController.days
                                  .indexOf(slotsController.selectedDay.value));
                          if (success) {
                            dynamicTimeSlots.insert(
                              dynamicTimeSlots.length,
                              {
                                "from": from,
                                "to": to,
                              },
                            );
                            availableTimeSlots.insert(
                              availableTimeSlots.length,
                              {
                                "startTime": fromTimes.last,
                                "endTime": toTimes.last,
                              },
                            );
                            fromTimes.insert(fromTimes.length, null);
                            toTimes.insert(toTimes.length, null);
                          }
                        } else {
                          if (slotsController.selectedDay.isEmpty) {
                            Helpers.toast('Day is Required.');
                            return;
                          }
                          Helpers.toast('From and To Time are Required.');
                        }

                        setState(() {});
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(aquaGreenColor),
                        minimumSize: WidgetStatePropertyAll<Size>(
                          Size(30.w, 5.h),
                        ),
                        shape: WidgetStatePropertyAll<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      child: Text(
                        'ADD',
                        style: TextStyle(
                          color: textBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addTimeSlotsDynamically(int index) {
    final textTheme = Theme.of(context).textTheme;
    print(fromTimes[index]);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30.w,
            height: 5.h,
            child: TextFormField(
              controller: fromTimes[index],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter start time';
                }
                return null;
              },
              onTap: () {
                if (fromTimes.indexOf(fromTimes.last) == index) {
                  _selectFromTime(context, index);
                }
              },
              readOnly: true,
              textAlign: TextAlign.center,
              style: textTheme.displayMedium?.copyWith(color: textWhiteColor),
              decoration: InputDecoration(
                  hintText: "from",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: textLightColor),
                  filled: true,
                  fillColor: shipGreyColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  // focusedBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: aquaGreenColor)),
                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: aquaGreenColor)),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Text(
            'TO',
            style: TextStyle(
              color: textWhiteColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          SizedBox(
            width: 30.w,
            height: 5.h,
            child: TextFormField(
              controller: toTimes[index],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter End time';
                }
                return null;
              },
              onTap: () {
                if (toTimes.indexOf(toTimes.last) == index) {
                  _selectToTime(context, index);
                }
              },
              readOnly: true,
              textAlign: TextAlign.center,
              style: textTheme.displayMedium?.copyWith(color: textWhiteColor),
              decoration: InputDecoration(
                  hintText: "To",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: textLightColor),
                  filled: true,
                  fillColor: shipGreyColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  // focusedBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: aquaGreenColor)),
                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: aquaGreenColor)),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          // DropdownButtonHideUnderline(
          //   child: DropdownButton2<String>(
          //     isExpanded: true,
          //     // Reduces the dropdowns height by +/- 50%
          //     hint: Row(
          //       children: [
          //         Expanded(
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(
          //               horizontal: 16.0,
          //             ),
          //             child: Text(
          //               'To',
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .headlineMedium
          //                   ?.copyWith(color: textLightColor),
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     iconStyleData: IconStyleData(
          //       icon: const Padding(
          //         padding: EdgeInsets.only(right: 8.0),
          //         child: Icon(
          //           Icons.keyboard_arrow_down,
          //           color: iconWhiteColor,
          //         ),
          //       ),
          //     ),
          //     value: toTimes[index],

          //     items: dynamicTimeSlots[index]['to']
          //         .map<DropdownMenuItem<String>>(
          //           (totime) => DropdownMenuItem<String>(
          //               value: totime,
          //               child: Padding(
          //                 padding: EdgeInsets.all(12),
          //                 child: Text(totime),
          //               )),
          //         )
          //         .toList(),
          //     // customItemsIndexes: _getDividersIndexes(),
          //     // customItemsHeight: 4,
          //     // value: selectedValue,
          //     onChanged: (value) {
          //       setState(() {
          //         toTimes[index] = value ?? '';
          //       });
          //     },

          //     dropdownStyleData: DropdownStyleData(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(14),
          //         color: shipGreyColor,
          //       ),
          //     ),
          //     style: TextStyle(
          //       color: textWhiteColor,
          //       fontSize: 14,
          //       fontWeight: FontWeight.w600,
          //     ),
          //     buttonStyleData: ButtonStyleData(
          //       height: 50,
          //       width: 30.w,
          //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(12),
          //         color: shipGreyColor,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
