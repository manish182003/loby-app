import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/order/dispute.dart';
import 'package:loby/domain/entities/profile/payment_transaction.dart';

import '../../profile/wallet_transaction.dart';



class DisputeResponse extends Equatable {

  final int count;
  final List<Dispute> disputes;

  const DisputeResponse({
    required this.count,
    required this.disputes,
  });

  @override
  List<Object> get props => [disputes];
}
