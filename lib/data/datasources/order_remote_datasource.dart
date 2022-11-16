import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:loby/data/models/response_models/order/order_response_model.dart';

import '../models/response_models/order/dispute_response_model.dart';

abstract class OrderRemoteDatasource{

  Future<Map<String, dynamic>> createOrder(int? listingId, int? quantity, String? price);

  Future<OrderResponseModel> getOrders(int? orderId, String? status, int? page);

  Future<Map<String, dynamic>> changeOrderStatus(int? orderId, String? status);

  Future<Map<String, dynamic>> uploadDeliveryProof(int? orderId, List<int>? fileType ,List<File>? file, String? link);

  Future<Map<String, dynamic>> submitRating(int? orderId, double? stars, String? review);

  Future<Map<String, dynamic>> selectDuelWinner(int? winnerId, int? orderId);

  Future<Map<String, dynamic>> raiseDispute(int? orderId, String? description);

  Future<DisputeResponseModel> getDisputes(int? page, String? status);

  Future<Map<String, dynamic>> submitDisputeProof(int? disputeId, String? description, List<int>? fileTypes, List<PlatformFile>? files, String? link);

}