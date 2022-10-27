// ignore_for_file: overridden_fields, annotate_overrides



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
