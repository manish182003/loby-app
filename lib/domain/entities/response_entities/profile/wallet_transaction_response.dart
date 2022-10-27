import 'package:equatable/equatable.dart';

import '../../profile/wallet_transaction.dart';



class WalletTransactionResponse extends Equatable {

  final int count;
  final List<WalletTransaction> walletTransactions;

  const WalletTransactionResponse({
    required this.count,
    required this.walletTransactions,
  });

  @override
  List<Object> get props => [walletTransactions];
}
