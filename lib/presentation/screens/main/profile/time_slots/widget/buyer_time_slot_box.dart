import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/getx/controllers/profile_controller.dart';
import 'package:loby/presentation/getx/controllers/slots_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../domain/entities/slots/get_slots_for_buyer.dart';

class BuyerTimeSlotBox extends StatefulWidget {
  final GetSlotsForBuyer getBuyerSlots;
  const BuyerTimeSlotBox({super.key, required this.getBuyerSlots});

  @override
  State<BuyerTimeSlotBox> createState() => _BuyerTimeSlotBoxState();
}

class _BuyerTimeSlotBoxState extends State<BuyerTimeSlotBox> {
  SlotsController slotsController = Get.find<SlotsController>();
  AuthController authController = Get.find<AuthController>();
  OrderController orderController = Get.find<OrderController>();
  final controller = ScrollController();
  Rx<DateFormat> format2 = DateFormat('MMMM yyyy').obs;

  DateTime _currentDate = DateTime.now();

  final bookSlotArr = [].obs;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   slotsController.getSlots(sellerId: 1);

    //   controller.addListener(() {
    //     if (controller.position.maxScrollExtent == controller.offset) {
    //       slotsController.getSlots();
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String fromtimeIn24HourFormat = "${widget.getBuyerSlots.from}";
    DateTime fromtime24Hour = DateFormat('HH:mm').parse(fromtimeIn24HourFormat);
    String fromtimeIn12HourFormat = DateFormat('h:mm a').format(fromtime24Hour);

    String totimeIn24HourFormat = "${widget.getBuyerSlots.to}";
    DateTime totime24Hour = DateFormat('HH:mm').parse(totimeIn24HourFormat);
    String totimeIn12HourFormat = DateFormat('h:mm a').format(totime24Hour);
    final me = Get.find<ProfileController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: Obx(() {
        if (slotsController.buyerSlots.isNotEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  slotsController.selectSlotArr.value = [widget.getBuyerSlots];
                  slotsController.selectSlotArr.refresh();
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: slotsController.selectSlotArr.any((element) =>
                                  element.id == widget.getBuyerSlots.id)
                              ? gambogeOrangeColor
                              : orderController.orders.any((element) =>
                                      element.userId == me.profile.id &&
                                      element.slotId == widget.getBuyerSlots.id)
                                  ? iconYellowColor
                                  : widget.getBuyerSlots.isBooked == "N"
                                      ? aquaGreenColor
                                      : lavaRedColor,
                          strokeAlign: 1)),
                  child: Center(
                    child: Text(
                      "$fromtimeIn12HourFormat - $totimeIn12HourFormat",
                      style: textTheme.headlineMedium
                          ?.copyWith(color: textWhiteColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                  orderController.orders.any((element) =>
                          element.userId == me.profile.id &&
                          element.slotId == widget.getBuyerSlots.id)
                      ? "Your Booking"
                      : widget.getBuyerSlots.isBooked == "N"
                          ? "Available"
                          : "Not Available",
                  style: textTheme.titleLarge?.copyWith(
                      color: orderController.orders.any((element) =>
                              element.userId == me.profile.id &&
                              element.slotId == widget.getBuyerSlots.id)
                          ? iconYellowColor
                          : widget.getBuyerSlots.isBooked == "N"
                              ? aquaGreenColor
                              : lavaRedColor,
                      fontWeight: FontWeight.w100)),
              SizedBox(
                height: 1.h,
              ),
            ],
          );
        }
        return const Text("null");
      }),
    );
  }

  Widget name() {
    return Text("${widget.getBuyerSlots.userdetail!.name}");
  }
}
