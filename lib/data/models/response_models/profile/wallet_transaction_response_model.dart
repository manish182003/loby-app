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

import '../../../../domain/entities/response_entities/profile/wallet_transaction_response.dart';
import '../../profile/wallet_transaction_model.dart';


class WalletTransactionResponseModel extends WalletTransactionResponse {

  final int count;
  final List<WalletTransactionModel> walletTransactions;

  const WalletTransactionResponseModel({
    required this.count,
    required this.walletTransactions,
  }) : super(count: count, walletTransactions: walletTransactions);

  @override
  List<Object> get props => [walletTransactions];

  factory WalletTransactionResponseModel.fromJSON(Map<String, dynamic> json) =>
      WalletTransactionResponseModel(
        count: json['data']['count'],
        walletTransactions: (json['data']['rows'] as List<dynamic>)
            .map<WalletTransactionModel>((transaction) => WalletTransactionModel.fromJson(transaction))
            .toList(),
      );
}
