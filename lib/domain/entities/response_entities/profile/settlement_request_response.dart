import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/settlement_request.dart';

import '../../profile/wallet_transaction.dart';



class SettlementRequestResponse extends Equatable {

  final int count;
  final List<SettlementRequest> settlementRequests;

  const SettlementRequestResponse({
    required this.count,
    required this.settlementRequests,
  });

  @override
  List<Object> get props => [settlementRequests];
}
