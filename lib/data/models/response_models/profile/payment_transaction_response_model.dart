// ignore_for_file: overridden_fields, annotate_overrides


import 'package:loby/data/models/profile/payment_transaction_model.dart';
import 'package:loby/domain/entities/response_entities/profile/payment_transaction_response.dart';


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
