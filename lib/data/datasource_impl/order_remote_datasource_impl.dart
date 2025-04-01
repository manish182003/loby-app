// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/models/response_models/order/dispute_response_model.dart';
import 'package:loby/data/models/response_models/order/order_response_model.dart';

import '../datasources/order_remote_datasource.dart';

class OrderRemoteDatasourceImpl extends OrderRemoteDatasource {
  final Dio _dio;
  OrderRemoteDatasourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> createOrder(
      int? listingId,
      int? quantity,
      String? price,
      String? bookFromTime,
      String? bookToTime,
      String? bookDate,
      bool? isUpdatingTime) async {
    String token = await Helpers.getApiToken();
    final Map<String, dynamic> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> data = {
      'user_game_service_id': "${listingId ?? ''}",
      'quantity': "${quantity ?? ''}",
      'price': price ?? '',
    };

    if (isUpdatingTime == true) {
      data.addAll({
        'booked_from_time': bookToTime ?? '',
        'booked_to_time': bookDate ?? '',
        'booked_date': bookFromTime ?? ''
      });
    }

    try {
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.createOrder,
        // extra: {
        //   'user_game_service_id': "${listingId ?? ''}",
        //   'quantity': "${quantity ?? ''}",
        //   'price': price ?? '',
        //   'booked_from_time': bookToTime ?? '',
        //   'booked_to_time': bookDate ?? '',
        //   'booked_date': bookFromTime ?? ''
        // },
        extra: data,
        headers: headers,
      );
      print("orderremoteimpl >> $bookDate");
      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<OrderResponseModel> getOrders(
      int? orderId, String? status, int? page) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getOrders,
        extra: {
          'user_order_id': "${orderId ?? ""}",
          'status': status,
          'page': '${page ?? ''}'
        },
        headers: headers,
      );

      return OrderResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> changeOrderStatus(
      int? orderId, String? status) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.changeOrderStatus,
        extra: {'user_order_id': "${orderId ?? ""}", 'status': status},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> uploadDeliveryProof(
      int? orderId, List<int>? fileType, List<File>? file, String? link) async {
    try {
      print("here is the link $link");

      final headers = await Helpers.getApiHeaders();

      FormData formData = FormData()
        ..fields.add(
          MapEntry('user_order_id', "${orderId ?? ''}"),
        );

      if (file != null) {
        formData.fields.add(MapEntry('type', "${fileType ?? ''}"));
        for (int i = 0; i < file.length; i++) {
          formData.files.add(MapEntry(
              'file',
              MultipartFile.fromFileSync(
                file[i].path,
                // contentType: MediaType('image', 'jpg'),
              )));
        }
      }

      if (link != null) {
        formData.fields.add(
          MapEntry('file_link', link),
        );
      }

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.uploadDeliveryProof,
        data: formData,
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> submitRating(
      int? orderId, double? stars, String? review) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.submitRating,
        extra: {
          'user_order_id': "${orderId ?? ""}",
          'star': '${stars ?? ''}',
          'comments': review
        },
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> selectDuelWinner(
    int? winnerId,
    int? orderId,
  ) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.selectDuelWinner,
        extra: {
          'winner_id': "${winnerId ?? ""}",
          'user_order_id': "${orderId ?? ""}",
        },
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> raiseDispute(
      int? orderId, String? description) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.raiseDispute,
        extra: {'user_order_id': "${orderId ?? ""}"},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<DisputeResponseModel> getDisputes(
      int? id, int? page, String? status) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getDisputes,
        extra: {
          'page': "${id != null ? '' : page ?? ""}",
          'status': status ?? "",
          "id": "$id"
        },
        headers: headers,
      );

      return DisputeResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> submitDisputeProof(
      int? disputeId,
      String? description,
      List<int>? fileTypes,
      List<PlatformFile>? files,
      String? link) async {
    try {
      final headers = await Helpers.getApiHeaders();

      FormData formData = FormData()
        ..fields.add(
          MapEntry('dispute_id', "${disputeId ?? ''}"),
        )
        ..fields.add(
          MapEntry('description', description ?? ''),
        );

      if (link != null) {
        formData.fields.add(
          MapEntry('file_link', link),
        );
      }

      if (files!.isNotEmpty) {
        for (int i = 0; i < files.length; i++) {
          formData.files.add(MapEntry(
              'file_path',
              MultipartFile.fromFileSync(
                files[i].path!,
                // contentType: MediaType('image', 'jpg'),
              )));
        }

        formData.fields.add(
          MapEntry('type', "$fileTypes"),
        );
      }

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.submitDeliveryProof,
        data: formData,
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
