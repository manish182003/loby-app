import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/theme/colors.dart';
import 'package:loby/domain/entities/slots/get_slots_for_seller.dart';
import 'package:loby/presentation/getx/controllers/auth_controller.dart';
import 'package:loby/presentation/getx/controllers/slots_controller.dart';
import 'package:sizer/sizer.dart';

class SellerTimeSlotBox extends StatefulWidget {
  final GetSlotsForSeller getSlots;
  const SellerTimeSlotBox({super.key, required this.getSlots});

  @override
  State<SellerTimeSlotBox> createState() => _SellerTimeSlotBoxState();
}

class _SellerTimeSlotBoxState extends State<SellerTimeSlotBox> {
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
    print('frommmm >>> ${widget.getSlots.from}');

    String fromtimeIn24HourFormat = "${widget.getSlots.from}";
    DateTime fromtime24Hour = DateFormat('HH:mm').parse(fromtimeIn24HourFormat);
    String fromtimeIn12HourFormat = DateFormat('h:mm a').format(fromtime24Hour);

    String totimeIn24HourFormat = "${widget.getSlots.to}";
    DateTime totime24Hour = DateFormat('HH:mm').parse(totimeIn24HourFormat);
    String totimeIn12HourFormat = DateFormat('h:mm a').format(totime24Hour);

    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: aquaGreenColor, strokeAlign: 1)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$fromtimeIn12HourFormat - $totimeIn12HourFormat",
                      style: textTheme.displayMedium
                          ?.copyWith(color: textWhiteColor),
                    ),
                    InkWell(
                      onTap: () {
                        _deleteDialog(context);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: lightGreyColor,
                      ),
                    )
                  ],
                ),
              )
              // Center(
              //   child: Text(
              //     "08:00 am - 10:00 am",
              //     style: textTheme.headline4
              //         ?.copyWith(color: textWhiteColor),
              //   ),
              // ),
              ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDialog(BuildContext context) async {
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
                Text('Are you sure?',
                    style: textTheme.headlineSmall
                        ?.copyWith(color: textWhiteColor)),
                Text('You want to delete this slot',
                    style: textTheme.headlineSmall
                        ?.copyWith(color: textWhiteColor)),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 26.w,
                ),
                TextButton(
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: aquaGreenColor),
                  ),
                  onPressed: () {
                    slotsController
                        .deleteSlots(slotId: widget.getSlots.slotId)
                        .then((value) {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
