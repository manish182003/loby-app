import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/main.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/getx/controllers/slots_controller.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:sizer/sizer.dart';

class BuyerTimeSlot extends StatefulWidget {
  bool? isEditing;
  final int id;
  BuyerTimeSlot({super.key, required this.id, this.isEditing = false});

  @override
  State<BuyerTimeSlot> createState() => _BuyerTimeSlotState();
}

class _BuyerTimeSlotState extends State<BuyerTimeSlot> {
  SlotsController slotsController = Get.find<SlotsController>();
  AuthController authController = Get.find<AuthController>();
  OrderController orderController = Get.find<OrderController>();
  final controller = ScrollController();
  Rx<DateFormat> format2 = DateFormat('MMMM yyyy').obs;
  List<DateTime> visibleDates = [];
  final ScrollController _scrollController = ScrollController();

  DateTime _currentDate = DateTime.now();

  Future<void> getBuyerSlots() async {
    // slotsController.getSlots();
    slotsController.areMoreSlotsAvailable.value = true;
    // slotsController.editSlot(
    //     date: orderController.orders.first.bookDate,
    //     orderId: orderController.orders.first.id,
    //     slotId: orderController.orders.first.slotId);
    slotsController.getBuyerSlots(
        providerId: widget.id,
        date: DateFormat('yyyy-MM-dd').format(_currentDate));
  }

  // final selectedIndex = 0.obs;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;

  void _addNextMonthDates() {
    DateTime lastDate = visibleDates.last;
    DateTime nextMonth = DateTime(lastDate.year, lastDate.month + 1, 1);
    DateTime endOfNextMonth = DateTime(nextMonth.year, nextMonth.month + 1, 0);

    for (int i = 0; i < endOfNextMonth.difference(nextMonth).inDays + 1; i++) {
      visibleDates.add(nextMonth.add(Duration(days: i)));
    }
    // setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMonthsData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _addNextMonthDates(); // 👇
      }
    });
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        slotsController.selectDateofCale.value =
            DateFormat('yyyy-MM-dd').format(DateTime.now());
        slotsController.selectDateofCale.refresh();
        getBuyerSlots();
      },
    );

    // getBuyerSlots();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   slotsController.getSlots(sellerId: 1);

    //   controller.addListener(() {
    //     if (controller.position.maxScrollExtent == controller.offset) {
    //       slotsController.getSlots();
    //     }
    //   });
    // });
  }

  // Future<void> getBuyerSlots() async {
  //   slotsController.providerid.value = 1;
  //   slotsController.areMoreSlotsAvailable.value = true;
  //   slotsController.getBuyerSlots();
  // }

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

  getMonthsData() {
    DateTime today = DateTime.now();
    DateTime lastDayOfCurrentMonth = DateTime(today.year, today.month + 1, 0);

    for (int i = 0;
        i <= lastDayOfCurrentMonth.difference(today).inDays + 1;
        i++) {
      visibleDates.add(today.add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    print("slecteddddd ${slotsController.selectSlotArr}");
    print("lenghttttttttttttttttttttt >> ${slotsController.buyerSlots.length}");
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: Row(
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
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'Available Time Slots',
                          style: TextStyle(
                            color: textWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 10.0.w),
                child: SizedBox(
                  height: 7.h,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: visibleDates.length,
                    itemBuilder: (context, index) {
                      DateTime date = visibleDates[index];
                      return selectDate(
                        0,
                        chooseDate: DateFormat('yyyy-MM-dd').format(date),
                        formDay: DateFormat('EEE').format(date)[0],
                        date: DateFormat('dd').format(date),
                        pId: widget.id,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Obx(() {
                if (slotsController.buyerSlots.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Color(0xFF00FF62),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 2.h),
                          height: 40.h,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: slotsController.buyerSlots.map((slot) {
                                String fromtimeIn24HourFormat = "${slot.from}";
                                DateTime fromtime24Hour = DateFormat('HH:mm')
                                    .parse(fromtimeIn24HourFormat);
                                String fromtimeIn12HourFormat =
                                    DateFormat('h:mm a').format(fromtime24Hour);

                                String totimeIn24HourFormat = "${slot.to}";
                                DateTime totime24Hour = DateFormat('HH:mm')
                                    .parse(totimeIn24HourFormat);
                                String totimeIn12HourFormat =
                                    DateFormat('h:mm a').format(totime24Hour);
                                return GestureDetector(
                                  onTap: () {
                                    slotsController.selectSlotArr.value = [
                                      slot
                                    ];
                                    slotsController.selectSlotArr.refresh();
                                  },
                                  child: Container(
                                    width: 26.w,
                                    height: 5.h,
                                    margin: EdgeInsets.only(right: 3, top: 5),
                                    decoration: BoxDecoration(
                                      color: slotsController.selectSlotArr.any(
                                              (element) =>
                                                  element.id == slot.id)
                                          ? Color(0xFFFF754C)
                                          : shipGreyColor,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Center(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    '$fromtimeIn12HourFormat - ',
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
                                );
                              }).toList(),
                            ),
                          )

                          // ListView.builder(
                          //   scrollDirection: Axis.vertical,
                          //   shrinkWrap: true,
                          //   itemCount:
                          //       slotsController.buyerSlots.length,
                          //   itemBuilder: (context, index) {
                          //     return BuyerTimeSlotBox(
                          //         getBuyerSlots: slotsController
                          //             .buyerSlots[index]);
                          //   },
                          // ),
                          // ),
                          // ),
                          ),
                      SizedBox(
                        height: 1.h,
                      ),
                      CustomButton(
                          name: "Confirm",
                          textColor: textBlackColor,
                          color: Color(0xFF00FF62),
                          left: 30.w,
                          right: 30.w,
                          fontSize: 11.spa,
                          // bottom: 1.h,
                          onTap: () async {
                            slotsController
                                .editSlot(
                                  date: slotsController.selectDateofCale.value,
                                  orderId:
                                      orderController.selectedOrder.value.id,

                                  slotId:
                                      slotsController.selectSlotArr.first.id,
                                  // isUpdatingTime: true,
                                  // listingId: orderController
                                  //     .selectedOrder
                                  //     .value
                                  //     .userGameServiceId!,
                                  // quantity: orderController
                                  //     .selectedOrder.value.quantity!,
                                  // price: orderController
                                  //     .selectedOrder.value.price
                                  //     .toString(),
                                  // bookDate: slotsController
                                  //     .selectDateofCale.first
                                  //     .toString(),
                                  // bookFromTime: slotsController
                                  //     .selectSlotArr.first.from,
                                  // bookToTime: slotsController
                                  //     .selectSlotArr.first.to,
                                )
                                .then((value) => _successDialog(context));
                            print(
                                " buyerdatepage >>>  ${slotsController.selectDateofCale.value}");
                          }),
                    ],
                  );
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Center(
                    child: Text(
                      "No slots found!",
                      style: TextStyle(
                        color: textWhiteColor,
                        fontSize: 14.spa,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _successDialog(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundDarkJungleGreenColor,

          // title: Text('Delete Slot'),

          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("Slot Booking Done",
                    style: textTheme.displayMedium?.copyWith(
                        color: textWhiteColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 2.h,
                ),
                const Image(
                    image: AssetImage("assets/images/success_logo.png")),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),

          actions: <Widget>[
            CustomButton(
                height: 8.h,
                fontSize: 15.sp,
                name: "Done",
                color: aquaGreenColor,

                // left: 0.w,
                // right: 0.w,
                bottom: 3.h,
                top: 2.h,
                onTap: () async {
                  // context.pushNamed(myOrderPage);
                  contextKey.currentContext?.pop();
                }),
          ],
          //   Column(
          //     children: <Widget>[
          //       Image(image: AssetImage("assets/images/success.jpg"))
          //     ],
          //   ),
          // ),
          // actions: <Widget>[
          //   TextButton(
          //     child: Text(
          //       'Done',
          //       style: TextStyle(color: aquaGreenColor),
          //     ),
          //     onPressed: () {
          //       context.pushNamed(mainPage);
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}

Widget selectDate(int i,
    {required String chooseDate,
    required String formDay,
    required String date,
    Color? colors,
    required int pId}) {
  String? currentDate;
  int? selectDateIndex = 0;

  SlotsController slotsController = Get.find<SlotsController>();

  dynamic theme = GoogleFonts.poppins(
    fontSize: 10.2,
    fontWeight: FontWeight.w300,
    height: 1.5,
    color: slotsController.selectDateofCale.value.contains(chooseDate)
        ? textBlackColor
        : textWhiteColor,
  );
  dynamic theme1 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: slotsController.selectDateofCale.value.contains(chooseDate)
        ? textBlackColor
        : textWhiteColor,
  );

  print("slecwdjckjcbck >>>> $chooseDate");
  print(selectDateIndex);
  print(i);
  return GestureDetector(
    onTap: () {
      // dateStore = chooseDate;
      // print("chooseDate");
      // print(dateStore);
      // print(chooseDate);
      // print("chooseDate");
      // currentDate = "";
      // selectDateIndexDefult = -1;
      // // availbale.getAvailablity(doctorId: widget.doctorId, date: chooseDate);
      // selectDateIndex = i;
      // selectValue = title;
      // dayValue.value = title;
      // dateSelect = selectDate;
      // print("selectDate");
      // print(selectDate);
      // print(title);
      // print("selectDate");
      // eveningSelectIndex = -1;
      // afterNoonSelectIndex = -1;
      // morselectIndex = -1;
      // nightSelectIndex = -1;
      slotsController.selectDateofCale.value = '';
      print('choosen date->$chooseDate');
      slotsController.selectDateofCale.value = chooseDate;
      slotsController.selectDateofCale.refresh();
      slotsController.getBuyerSlots(date: chooseDate, providerId: pId);
      print("chooosseeee >> $chooseDate");
      // setState(() {});
    },
    child: Obx(
      () => Container(
          margin: const EdgeInsets.only(left: 8),
          padding: const EdgeInsets.fromLTRB(4, 5, 4, 6),
          width: 36,
          // height: 71,
          decoration: BoxDecoration(
            color: slotsController.selectDateofCale.value.contains(chooseDate)
                ? Color(0xFF00FF62)
                : textCharcoalBlueColor,
            // color: chooseDate.isNotEmpty ? orangeColor : textCharcoalBlueColor,

            //  currentDate == chooseDate && currentDate != ""
            //     ? orangeColor
            //     : i != selectDateIndex
            //         ? textCharcoalBlueColor
            //         : orangeColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Center(
              child: Obx(
                () => Text(
                  formDay,
                  style: GoogleFonts.poppins(
                    fontSize: 10.2,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                    color: slotsController.selectDateofCale.value
                            .contains(chooseDate)
                        ? textBlackColor
                        : textWhiteColor,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 1, 0),
              child: Obx(
                () => Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: slotsController.selectDateofCale.value
                            .contains(chooseDate)
                        ? textBlackColor
                        : textWhiteColor,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 1, 0),
              child: Obx(
                () => Text(
                  DateFormat('MMM').format(DateTime.parse(chooseDate)),
                  style: GoogleFonts.poppins(
                    fontSize: 10.2,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                    color: slotsController.selectDateofCale.value
                            .contains(chooseDate)
                        ? textBlackColor
                        : textWhiteColor,
                  ),
                ),
              ),
            ),
          ])),
    ),
  );
}
