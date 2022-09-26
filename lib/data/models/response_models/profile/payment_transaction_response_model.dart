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
import 'package:loby/domain/entities/response_entities/profile/payment_transaction_response.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';


class PaymentTransactionResponseModel extends PaymentTransactionResponse {

  final int count;
  final List<PaymentTransactionModel> paymentTransactions;

  const PaymentTransactionResponseModel({
    required this.count,
    required this.paymentTransactions,
  }) : super(count: count, paymentTransactions: paymentTransactions);

  @override
  List<Object> get props => [paymentTransactions];

  factory PaymentTransactionResponseModel.fromJSON(Map<String, dynamic> json) =>
      PaymentTransactionResponseModel(
        count: json['data']['count'],
        paymentTransactions: (json['data']['rows'] as List<dynamic>)
            .map<PaymentTransactionModel>((transaction) => PaymentTransactionModel.fromJson(transaction))
            .toList(),
      );
}
