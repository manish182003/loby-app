// import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
// ignore: implementation_imports
// import 'package:flutter/src/widgets/editable_text.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/datasources/slots_remote_datasource.dart';
import 'package:loby/data/models/response_models/slots/get_buyer_slots_response.dart';
import 'package:loby/data/models/response_models/slots/get_slots_response.dart';
// import 'package:loby/data/models/slots/get_buyer_slots_model.dart';
// import 'package:loby/data/models/slots/get_slots_model.dart';
// import 'package:loby/domain/entities/response_entities/slots/delete_slot.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_buyer.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';

class SlotsRemoteDatasourceImpl extends SlotsRemoteDatasource {
  final Dio _dio;

  SlotsRemoteDatasourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> addSlots(
      int? slotId, int? day, String? from, String? to) async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      var data = {"day": day, "from": from, "to": to};

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.addSlots,
        data: data,
        headers: headers,
      );

      return response!['data'];
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GetSlotsForSellerResponse> getSlots(int? day, int? providerId) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getSlotsForSeller,
        queryParams: {'day': day, 'providerId': providerId},
        headers: headers,
      );

      return GetSlotResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GetSlotsForBuyerResponse> getBuyerSlots(
      String? date, int? providerId) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getSlots,
        queryParams: {'date': date, 'providerId': providerId},
        headers: headers,
      );

      return GetBuyerSlotResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String,dynamic>> deleteSlots(int? slotId) async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      var data = {"slot_id": slotId};

      final response = await Helpers.sendRequest(
          _dio, RequestType.post, ApiEndpoints.deleteSlot,
          queryParams: data, headers: headers, encoded: true);

      // print("respo msg >> $response");

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
  
  @override
  Future<Map<String,dynamic>> editSlots(String? date, int? orderId, int? slotId) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.editSlot,
        queryParams: {'booked_date': date, "slot_id" : slotId, "order_id" : orderId},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

//   @override
//   Future<GetSlotsModel> getSlots(int? sellerId, int? slotId, int? day, String? from, String? to, String? isBooked, int? providerId, String? date) async {
//     try {
//       String token = await Helpers.getApiToken();
//       final Map<String, dynamic> headers = {
//         'Authorization': 'Bearer $token',
//       };

//       final response = await Helpers.sendRequest(
//         _dio,
//         RequestType.get,
//         from == 'myProfile' ? ApiEndpoints.getSlotsForSeller : ApiEndpoints.getSlots,
//         queryParams: {
//           'seller_id': '${sellerId}',
//           'slot_id': '${slotId}',
//           'day': '${day}',
//           'day_id': '${day}',
//           // 'from': '${from}',
//           'to' : '${to}',
//           'isBooked' : '${isBooked}',
//           'providerId' : '${providerId}',
//           'date': '${date}'
//         },
//         headers: headers,
//       );

//       return GetSlotsModel.fromJson(response!);
//     } on ServerException catch (e) {
//       throw ServerException(message: e.message);
//     }
//   }
}
