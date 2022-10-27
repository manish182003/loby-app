import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/order/dispute.dart';




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
