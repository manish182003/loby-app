

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/usecases/home_params.dart';
import 'package:loby/core/usecases/order_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/home/category_games.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:loby/domain/entities/home/notification.dart' as notification;
import 'package:loby/domain/entities/order/order.dart';
import 'package:loby/domain/usecases/order/create_order.dart';
import 'package:loby/domain/usecases/home/delete_notification.dart';
import 'package:loby/domain/usecases/home/get_categories.dart';
import 'package:loby/domain/usecases/home/get_category_games.dart';
import 'package:loby/domain/usecases/home/get_games.dart';
import 'package:loby/domain/usecases/home/get_notifications.dart';
import 'package:loby/domain/usecases/order/get_orders.dart';
import 'package:loby/domain/usecases/home/get_unread_count.dart';
import 'package:loby/domain/usecases/order/select_duel_winner.dart';

import '../../../domain/usecases/order/change_order_status.dart';
import '../../../domain/usecases/order/submit_rating.dart';
import '../../../domain/usecases/order/upload_delivery_proof.dart';

class OrderController extends GetxController{

  final CreateOrder _createOrder;
  final GetOrders _getOrders;
  final ChangeOrderStatus _changeOrderStatus;
  final UploadDeliveryProof _uploadDeliveryProof;
  final SubmitRating _submitRating;
  final SelectDuelWinner _selectDuelWinner;

  OrderController({

    required CreateOrder createOrder,
    required GetOrders getOrders,
    required ChangeOrderStatus changeOrderStatus,
    required UploadDeliveryProof uploadDeliveryProof,
    required SubmitRating submitRating,
    required SelectDuelWinner selectWinnerDuel,

  }) :
        _createOrder = createOrder,
        _getOrders = getOrders,
  _changeOrderStatus = changeOrderStatus,
        _uploadDeliveryProof = uploadDeliveryProof,
        _submitRating = submitRating,
        _selectDuelWinner = selectWinnerDuel;

  final orders = <Order>[].obs;
  final isOrdersFetching = false.obs;


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
    isOrdersFetching(true);
    final failureOrSuccess = await _getOrders(
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
        isOrdersFetching(false);
      },
          (success) {
        orders.value = success.orders;
        isOrdersFetching(false);
        // Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
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
        Helpers.toast('SUCCESS');
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

}