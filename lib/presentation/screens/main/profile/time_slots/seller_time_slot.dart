import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/slots_controller.dart';
import 'package:loby/presentation/screens/main/profile/time_slots/add_slot_dialog.dart';
import 'package:loby/presentation/screens/main/profile/time_slots/widget/seller_time_slot_box.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:sizer/sizer.dart';

class SellerTimeSlot extends StatefulWidget {
  // final GetSlotsForSeller getSlots;
  // final int? slotId;
  const SellerTimeSlot({
    super.key,
  });

  @override
  State<SellerTimeSlot> createState() => _SellerTimeSlotState();
}

class _SellerTimeSlotState extends State<SellerTimeSlot> {
  SlotsController slotsController = Get.find<SlotsController>();
  AuthController authController = Get.find<AuthController>();
  final controller = ScrollController();
  Rx<DateFormat> format2 = DateFormat('MMMM yyyy').obs;

  DateTime _currentDate = DateTime.now();

  void _initializeDateFormat() {
    // initializeDateFormat('fr_FR');
  }

  void _changeMonth(int monthsToAdd) {
    setState(() {
      _currentDate =
          DateTime(_currentDate.year, _currentDate.month + monthsToAdd);
    });
  }

  bool _isBeforeCurrentDate(DateTime date) {
    final today = DateTime.now();
    return date.isBefore(DateTime(today.year, today.month, today.day));
  }

  int selectedIndex = 0;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    getSlots();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   slotsController.getSlots(sellerId: 1);

    //   controller.addListener(() {
    //     if (controller.position.maxScrollExtent == controller.offset) {
    //       slotsController.getSlots();
    //     }
    //   });
    // });
  }

  Future<void> getSlots() async {
    // slotsController.getSlots();
    slotsController.areMoreSlotsAvailable.value = true;
    slotsController.getSlots();
  }

  void onTap(String day) {
    setState(() {
      if (slotsController.selectedDay.contains(day)) {
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    print("length >>>> ${slotsController.slots.length}");
    print("selecteddayyyyy 46547687 ${slotsController.selectedDay}");
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/login_bg_img.jpeg"),
                    opacity: 0.5,
                    fit: BoxFit.fill)),
          ),
          Obx(() {
            if (slotsController.selectedDay.isNotEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 42,
                                    height: 42,
                                    child: MaterialButton(
                                      shape: const CircleBorder(),
                                      color: textCharcoalBlueColor,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  )
                                ],
                              ),
                            ),
                          )),
                      // SizedBox(height: 10.h,),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 49.0.w, left: 15, right: 15),
                        child: Align(
                            child: Container(
                          width: 100.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: aquaGreenColor,
                                    blurRadius: 10,
                                    offset: Offset(0, 0))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            child: Column(
                              children: [
                                Text(
                                  "Weekly Schedule",
                                  style: textTheme.displayMedium
                                      ?.copyWith(color: textWhiteColor),
                                ),
                                SizedBox(height: 4.h),
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    // shrinkWrap: true,
                                    itemCount: slotsController.days.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (!slotsController.selectedDay
                                              .contains(slotsController
                                                  .days[index])) {
                                            onTap(slotsController.days[index]);
                                            slotsController.getSlots();
                                          }
                                        },
                                        child: Container(
                                          height: 14.h,
                                          width: 10.w,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 1.2.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: slotsController.selectedDay
                                                    .contains(slotsController
                                                        .days[index])
                                                ? orangeColor
                                                : shipGreyColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: CircleAvatar(
                                              backgroundColor: whiteColor,
                                              child: Text(
                                                slotsController.days[index],
                                                style: const TextStyle(
                                                    color: textBlackColor,
                                                    fontSize: 8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Container(
                        height: 51.h,
                        width: MediaQuery.of(context).size.width,
                        // child: Text("hellooo", style: TextStyle(color: Colors.amber , fontSize: 60),),
                        decoration: const BoxDecoration(
                            color: backgroundColor,
                            // border: Border(top: BorderSide(color: Colors.white)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                        // child: Text("Login", style: textTheme.headline2?.copyWith(color: textWhiteColor)),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 3.h),
                              height: 39.h,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: slotsController.slots.length,
                                itemBuilder: (context, index) {
                                  return SellerTimeSlotBox(
                                      getSlots: slotsController.slots[index]);
                                },
                              ),
                              // ),
                            ),
                            // SellerTimeSlotBox(getSlots: slotsController.slots[0]),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomButton(
                                name: "Add New Slot",
                                textColor: textWhiteColor,
                                color: purpleLightIndigoColor,
                                left: 4.w,
                                right: 4.w,
                                // bottom: 5.h,
                                onTap: () async {
                                  // _loginDialog(context);
                                  _addSlotDialog(
                                      context,
                                      slotsController.days.indexOf(
                                          slotsController.selectedDay.value));
                                }),
                          ],
                        )),
                  ),
                ],
              );
            }
            return const Text("Empty selectedDay");
          })
        ]),
      ),
    );
  }
}

void _addSlotDialog(BuildContext context, int selectedDayIndex) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddSlotDialog(selectedDayIndex: selectedDayIndex);
    },
  );
}
