import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/data/models/slots/get_slots_model.dart';
import 'package:loby/domain/entities/slots/get_slots_for_seller.dart';
import 'package:loby/domain/usecases/slots/get_slots.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/order_controller.dart';
import 'package:loby/presentation/getx/controllers/slots_controller.dart';
import 'package:loby/presentation/screens/main/profile/time_slots/add_slot_dialog.dart';
import 'package:loby/presentation/widgets/buttons/custom_button.dart';
import 'package:loby/presentation/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:drop_shadow/drop_shadow.dart';

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
    print('frommmm >>> ${widget.getBuyerSlots.from}');
    final textTheme = Theme.of(context).textTheme;
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
                              : widget.getBuyerSlots.isBooked == "N"
                                  ? aquaGreenColor
                                  : lavaRedColor,
                          strokeAlign: 1)),
                  child: Center(
                    child: Text(
                      "${widget.getBuyerSlots.from} - ${widget.getBuyerSlots.to}",
                      style:
                          textTheme.headline4?.copyWith(color: textWhiteColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                  widget.getBuyerSlots.isBooked == "N"
                      ? "Available"
                      : "Not Available",
                  style: textTheme.headline6?.copyWith(
                      color: widget.getBuyerSlots.isBooked == "N"
                          ? aquaGreenColor
                          : lavaRedColor,
                      fontWeight: FontWeight.w100)),
              SizedBox(
                height: 1.h,
              ),
            ],
          );
        }
        return Text("null");
      }),
    );
  }

  Widget name() {
    return Text("${widget.getBuyerSlots.userdetail!.name}");
  }
}
