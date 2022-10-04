// ignore_for_file: overridden_fields, annotate_overrides


import 'package:flutter/cupertino.dart';
import 'package:loby/data/models/auth/city_model.dart';
import 'package:loby/data/models/auth/country_model.dart';
import 'package:loby/data/models/listing/service_listing_model.dart';
import 'package:loby/data/models/profile/payment_transaction_model.dart';
import 'package:loby/data/models/profile/rating_model.dart';
import 'package:loby/domain/entities/auth/city.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/profile/payment_transaction.dart';
import 'package:loby/domain/entities/response_entities/auth/city_response.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/entities/response_entities/order/dispute_response.dart';
import 'package:loby/domain/entities/response_entities/profile/payment_transaction_response.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';

import '../../../../domain/entities/response_entities/profile/wallet_transaction_response.dart';
import '../../order/dispute_model.dart';
import '../../profile/wallet_transaction_model.dart';


class DisputeResponseModel extends DisputeResponse {

  final int count;
  final List<DisputeModel> disputes;

  const DisputeResponseModel({
    required this.count,
    required this.disputes,
  }) : super(count: count, disputes: disputes);

  @override
  List<Object> get props => [disputes];

  factory DisputeResponseModel.fromJSON(Map<String, dynamic> json) =>
      DisputeResponseModel(
        count: json['data']['count'],
        disputes: (json['data']['rows'] as List<dynamic>)
            .map<DisputeModel>((dispute) => DisputeModel.fromJson(dispute))
            .toList(),
      );
}
