import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/profile/payment_transaction.dart';

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
