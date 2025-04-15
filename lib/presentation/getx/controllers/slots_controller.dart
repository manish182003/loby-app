import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loby/core/usecases/buyer_slots_Params.dart';
import 'package:loby/core/usecases/delete_slot_params.dart';
import 'package:loby/core/usecases/edit_slot_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/slots/get_slots_for_buyer.dart';
import 'package:loby/domain/entities/slots/get_slots_for_seller.dart';
import 'package:loby/domain/usecases/slots/copy_slots_to_all_days.dart';
import 'package:loby/domain/usecases/slots/delete_slot.dart';
import 'package:loby/domain/usecases/slots/edit_slot.dart';
import 'package:loby/domain/usecases/slots/get_buyer_slots.dart';
import 'package:loby/domain/usecases/slots/get_slots.dart';

import '../../../core/usecases/slots_params.dart';
import '../../../domain/usecases/slots/add_slots.dart';

class SlotsController extends GetxController {
  final AddSlots _addSlots;
  final GetSlots _getSlots;
  final GetBuyerSlots _getBuyerSlots;
  final DeleteSlots _deleteSlots;
  final EditSlot _editSlot;
  final CopyToAlldaysSlots _copyToAlldaysSlots;

  SlotsController(
      {required AddSlots addSlots,
      required GetSlots getSlots,
      required GetBuyerSlots getBuyerSlots,
      required EditSlot editSlot,
      required DeleteSlots deleteSlots,
      required CopyToAlldaysSlots copySlots})
      : _addSlots = addSlots,
        _getSlots = getSlots,
        _getBuyerSlots = getBuyerSlots,
        _editSlot = editSlot,
        _deleteSlots = deleteSlots,
        _copyToAlldaysSlots = copySlots;

  final errorMessage = ''.obs;
  // List selectedDay = [].obs;
  final days = [
    "",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  RxString selectedDay = ''.obs;
  final slots = <GetSlotsForSeller>[].obs;
  final buyerSlots = <GetSlotsForBuyer>[].obs;

  String _convertTo24HourFormat(String time) {
    DateTime dateTime = DateFormat.jm().parse(time);
    return DateFormat.Hm().format(dateTime);
  }

  String sendFromDataToAPI() {
    // Get the time from the text field in 12-hour format
    String timeIn12HourFormat = fromTime.value.text;

    // Convert the time to 24-hour format for sending to the API
    String timeIn24HourFormat = _convertTo24HourFormat(timeIn12HourFormat);

    // Send data to API with time in 24-hour format
    print("Sending time to API: $timeIn24HourFormat");
    // Your API call logic goes here

    return timeIn24HourFormat;
  }

  String sendToDataToAPI() {
    // Get the time from the text field in 12-hour format
    String timeIn12HourFormat = toTime.value.text;

    // Convert the time to 24-hour format for sending to the API
    String timeIn24HourFormat = _convertTo24HourFormat(timeIn12HourFormat);

    // Send data to API with time in 24-hour format
    print("Sending time to API: $timeIn24HourFormat");
    // Your API call logic goes here

    return timeIn24HourFormat;
  }

  final fromTime = TextEditingController().obs;
  final toTime = TextEditingController().obs;
  // final day = TextEditingController().obs;
  final isSlotsFetching = false.obs;
  final areMoreSlotsAvailable = true.obs;
  final providerid = ''.obs;
  // final date = currentDate.obs;
  final slotday = ["Mon"].obs;

  Rx<DateFormat> format2 = DateFormat('yyyy-MM-dd').obs;

  DateTime currentDate = DateTime.now();

  final selectDateofCale = ''.obs;

  final selectSlotArr = <GetSlotsForBuyer>[].obs;

  final selectedListId = 0.obs;

  // dateinitlizer() {
  //   final date = currentDate.obs;

  // }

  Future<bool> addSlots({int? day, String? from, String? to}) async {
    Helpers.loader();
    final failureOrSuccess = await _addSlots(
      Params(
        slotsParams: SlotsParams(
          day: day,
          from: sendFromDataToAPI(),
          to: sendToDataToAPI(),
          // sellerId: sellerId,
        ),
      ),
    );

    failureOrSuccess.fold(
      (failure) {
        Helpers.hideLoader();
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
      (success) {
        getSlots();
        Helpers.hideLoader();
        Helpers.toast('Slots added Successfully');
        clearListing();
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<void> copySlotsToAllDays(int day) async {
    Helpers.loader();
    final failureOrSuccess = await _copyToAlldaysSlots(
      Params(
        slotsParams: SlotsParams(
          day: day,
        ),
      ),
    );

    failureOrSuccess.fold(
      (failure) {
        Helpers.hideLoader();
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
      (success) {
        getSlots();
        Helpers.hideLoader();
        Helpers.toast('Slots Copied To All days.');
      },
    );
  }

  void clearListing() {
    fromTime.value.clear();
    toTime.value.clear();
  }

  Future<bool> deleteSlots({int? slotId}) async {
    print('Deleteslot id => $slotId');
    final failureOrSuccess = await _deleteSlots(
      Params(
        deleteSlotsParams: DeleteSlotsParams(slotId: slotId),
      ),
    );

    failureOrSuccess.fold(
      (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
      (success) {
        // clearListing();
        slots.removeWhere((element) => element.slotId == slotId);
        slots.refresh();
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> getSlots({int? day, int? providerId}) async {
    // providerid.value == 1 ? isSlotsFetching(true) : isSlotsFetching(false);
    Helpers.loader();
    final userId = await Helpers.getUserId();

    if (areMoreSlotsAvailable.value) {
      final failureOrSuccess = await _getSlots(
        Params(
          slotsParams: SlotsParams(
            day: days.indexOf(selectedDay.value),
            providerId: userId,
            // slotId: slotId,
          ),
        ),
      );

      failureOrSuccess.fold(
        (failure) {
          Helpers.hideLoader();
          errorMessage.value = Helpers.convertFailureToMessage(failure);
          debugPrint(errorMessage.value);
          Helpers.toast(errorMessage.value);
          isSlotsFetching(false);
        },
        (success) {
          // areMoreSlotsAvailable.value = success.getSlotForSeller.length == 10;
          // slots.addAll(success.getSlotForSeller);
          slots.value = success.getSlotForSeller;
          Helpers.hideLoader();
          // if (providerid) {
          //   slots.addAll(success.getSlotForSeller);
          // } else {
          //   slots.value = success.getSlotForSeller;
          // }
          // providerid.value++;

          // isSlotsFetching.value = false;

          // Helpers.toast('slotsss');
        },
      );
      return failureOrSuccess.isRight() ? true : false;
    }
    return false;
  }

  Future<bool> getBuyerSlots({String? date, int? providerId}) async {
    // providerid.value == 1 ? isSlotsFetching(true) : isSlotsFetching(false);

    if (areMoreSlotsAvailable.value) {
      final failureOrSuccess = await _getBuyerSlots(Params(
          buyerSlotsParams: BuyerParams(date: date, providerId: providerId)));

      // print("currentttt >>>> ${currentDate.format('y-MM-dd')}");

      failureOrSuccess.fold(
        (failure) {
          errorMessage.value = Helpers.convertFailureToMessage(failure);
          debugPrint(errorMessage.value);
          Helpers.toast(errorMessage.value);
          isSlotsFetching(false);
        },
        (success) {
          // areMoreSlotsAvailable.value = success.getSlotForBuyer.length == 10;
          // buyerSlots.value = success.getSlotForBuyer;
          buyerSlots.value = success.getSlotForBuyer;
          buyerSlots.refresh();
          // buyerSlots.addAll(success.getSlotForBuyer);
          // if (providerid == 1) {

          //   buyerSlots.addAll(success.getSlotForBuyer);
          // } else {
          //   buyerSlots.value = success.getSlotForBuyer;
          // }
          // providerid.value++;

          isSlotsFetching.value = false;

          // Helpers.toast('slotsss');
        },
      );
      return failureOrSuccess.isRight() ? true : false;
    }
    return false;
  }

  Future<bool> editSlot({String? date, int? orderId, int? slotId}) async {
    // providerid.value == 1 ? isSlotsFetching(true) : isSlotsFetching(false);

    if (areMoreSlotsAvailable.value) {
      final failureOrSuccess = await _editSlot(Params(
          editSlotParams:
              EditSlotParams(date: date, orderId: orderId, slotId: slotId)));

      // print("currentttt >>>> ${currentDate.format('y-MM-dd')}");

      failureOrSuccess.fold(
        (failure) {
          errorMessage.value = Helpers.convertFailureToMessage(failure);
          debugPrint(errorMessage.value);
          Helpers.toast(errorMessage.value);
          isSlotsFetching(false);
        },
        (success) {
          // areMoreSlotsAvailable.value = success.getSlotForBuyer.length == 10;
          // buyerSlots.value = success.getSlotForBuyer;
          // buyerSlots.value = success.getSlotForBuyer;
          // buyerSlots.refresh();
          // buyerSlots.addAll(success.getSlotForBuyer);
          // if (providerid == 1) {

          //   buyerSlots.addAll(success.getSlotForBuyer);
          // } else {
          //   buyerSlots.value = success.getSlotForBuyer;
          // }
          // providerid.value++;

          isSlotsFetching.value = false;

          // Helpers.toast(success["message"]);
        },
      );
      return failureOrSuccess.isRight() ? true : false;
    }
    return false;
  }

//   Future<bool> getSlots(Params params,
//       {int? sellerId,
//       int? slotId,
//       int? day,
//       String? from,
//       String? to,
//       String? isBooked}) async {
//     final failureOrSuccess = await _getSlots(
//       Params(
//           slotsParams: SlotsParams(
//               date: dateinitlizer(),
//               day: day,
//               from: from,
//               isBooked: isBooked,
//               providerId: sellerId,
//               sellerId: sellerId,
//               slotId: slotId,
//               to: to)),
//     );

//     failureOrSuccess.fold(
//       (failure) {
//         errorMessage.value = Helpers.convertFailureToMessage(failure);
//         debugPrint(errorMessage.value);
//         Helpers.toast(errorMessage.value);
//         // isBuyerListingsFetching.value = false;
//       },
//       (success) {
//         print("successss $failureOrSuccess");
//       },
//     );
//     return failureOrSuccess.isRight() ? true : false;
//   }
}
