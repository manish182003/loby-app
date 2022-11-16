

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/usecases/order_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/order/dispute.dart';
import 'package:loby/domain/entities/order/order.dart';
import 'package:loby/domain/usecases/order/create_order.dart';
import 'package:loby/domain/usecases/order/get_orders.dart';
import 'package:loby/domain/usecases/order/raise_dispute.dart';
import 'package:loby/domain/usecases/order/select_duel_winner.dart';

import '../../../domain/entities/auth/selected_file.dart';
import '../../../domain/usecases/order/change_order_status.dart';
import '../../../domain/usecases/order/get_disputes.dart';
import '../../../domain/usecases/order/submit_dispute_proof.dart';
import '../../../domain/usecases/order/submit_rating.dart';
import '../../../domain/usecases/order/upload_delivery_proof.dart';

class OrderController extends GetxController{

  final CreateOrder _createOrder;
  final GetOrders _getOrders;
  final ChangeOrderStatus _changeOrderStatus;
  final UploadDeliveryProof _uploadDeliveryProof;
  final SubmitRating _submitRating;
  final SelectDuelWinner _selectDuelWinner;
  final RaiseDispute _raiseDispute;
  final GetDisputes _getDisputes;
  final SubmitDisputeProof _submitDisputeProof;


  OrderController({

    required CreateOrder createOrder,
    required GetOrders getOrders,
    required ChangeOrderStatus changeOrderStatus,
    required UploadDeliveryProof uploadDeliveryProof,
    required SubmitRating submitRating,
    required SelectDuelWinner selectWinnerDuel,
    required RaiseDispute raiseDispute,
    required GetDisputes getDisputes,
    required SubmitDisputeProof submitDisputeProof,

  }) :
        _createOrder = createOrder,
        _getOrders = getOrders,
  _changeOrderStatus = changeOrderStatus,
        _uploadDeliveryProof = uploadDeliveryProof,
        _submitRating = submitRating,
        _selectDuelWinner = selectWinnerDuel,
        _raiseDispute = raiseDispute,
        _getDisputes = getDisputes,
  _submitDisputeProof = submitDisputeProof;

  final orders = <Order>[].obs;
  final isOrdersFetching = false.obs;
  final areMoreOrdersAvailable = true.obs;
  final ordersPageNumber = 1.obs;
  

  final disputes = <Dispute>[].obs;
  final isDisputesFetching = false.obs;
  final areMoreDisputesAvailable = true.obs;
  final disputesPageNumber = 1.obs;

  final files = <PlatformFile>[].obs;
  final fileTypes = <int>[].obs;

  List<String> duelUsers = ['Challenger', 'You'];
  final selectedUser = "".obs;
  final selectedDuelProofs = <SelectedFile>[].obs;
  final duelWinner = ''.obs;
  final fileLink = TextEditingController().obs;





  final errorMessage = ''.obs;

  Future<bool> createOrder({required int listingId, required int quantity, required String price}) async {
    final failureOrSuccess = await _createOrder(
      Params(orderParams: OrderParams(
        listingId: listingId,
        quantity: quantity,
        price: price,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }



  Future<bool> getOrders({int? orderId, String? status}) async {
    ordersPageNumber.value == 1 ? isOrdersFetching(true) : isOrdersFetching(false);

    if(areMoreOrdersAvailable.value){
      final failureOrSuccess = await _getOrders(
        Params(orderParams: OrderParams(
            orderId: orderId,
            status: status,
            page: ordersPageNumber.value
        ),),
      );

      failureOrSuccess.fold(
            (failure) {
          errorMessage.value = Helpers.convertFailureToMessage(failure);
          debugPrint(errorMessage.value);
          Helpers.toast(errorMessage.value);
          isOrdersFetching(false);
        },
            (success) {

          areMoreOrdersAvailable.value = success.orders.length == 10;

          if (ordersPageNumber > 1) {
            orders.addAll(success.orders);
          } else {
            orders.value = success.orders;
          }
          ordersPageNumber.value++;

          isOrdersFetching.value = false;

          // Helpers.toast('Profile Changed');
        },
      );
      return failureOrSuccess.isRight() ? true : false;
    }
    return false;
  }

  Future<bool> changeOrderStatus({required int orderId, required String status}) async {
    final failureOrSuccess = await _changeOrderStatus(
      Params(orderParams: OrderParams(
        orderId: orderId,
        status: status,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
        Helpers.toast('Successfully Updated');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> uploadDeliveryProof({required int orderId, required List<int> fileTypes, required List<File>? files}) async {
    final failureOrSuccess = await _uploadDeliveryProof(
      Params(orderParams: OrderParams(
        orderId: orderId,
        fileType: fileTypes,
        file: files,
        link: fileLink.value.text,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> submitRating({required int orderId, required double stars, String? review}) async {
    final failureOrSuccess = await _submitRating(
      Params(orderParams: OrderParams(
        orderId: orderId,
        stars: stars,
        review: review,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> selectDuelWinner({required int winnerId, required int orderId}) async {
    final failureOrSuccess = await _selectDuelWinner(
      Params(orderParams: OrderParams(
        winnerId: winnerId,
        orderId: orderId,
        link: fileLink.value.text
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;

  }


  Future<bool> raiseDispute({required int orderId, String? description}) async {
    final failureOrSuccess = await _raiseDispute(
      Params(orderParams: OrderParams(
        orderId: orderId,
        description: description
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> getDisputes({String? status}) async {
    disputesPageNumber.value == 1 ? isDisputesFetching(true) : isDisputesFetching(false);

    if(areMoreDisputesAvailable.value){
      final failureOrSuccess = await _getDisputes(
        Params(orderParams: OrderParams(
          page: disputesPageNumber.value,
          status: status,
        ),),
      );

      failureOrSuccess.fold(
            (failure) {
          errorMessage.value = Helpers.convertFailureToMessage(failure);
          debugPrint(errorMessage.value);
          Helpers.toast(errorMessage.value);
          isDisputesFetching.value = false;
        },
            (success) {
              areMoreDisputesAvailable.value = success.disputes.length == 10;

              if (disputesPageNumber > 1) {
            disputes.addAll(success.disputes);
          } else {
            disputes.value = success.disputes;
          }

          disputesPageNumber.value++;

          isDisputesFetching.value = false;
        },
      );
      return failureOrSuccess.isRight() ? true : false;
    }
    return false;
  }


  Future<bool> submitDisputeProof({required int disputeId, String? description, String? link}) async {

    final failureOrSuccess = await _submitDisputeProof(
      Params(orderParams: OrderParams(
        disputeId: disputeId,
        description: description,
        files: files,
        fileTypes: fileTypes,
        link: link,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

        files.clear();
        fileTypes.clear();


      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }



}