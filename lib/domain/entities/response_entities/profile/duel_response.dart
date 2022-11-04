import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/duel_details.dart';
import 'package:loby/domain/entities/profile/duel_details_count.dart';



class DuelResponse extends Equatable {
  final DuelDetailsCount duelDetailsCount;
  final List<DuelDetails> duelDetailsList;
  // final DuelDetails duelDetails;

  const DuelResponse({
    required this.duelDetailsCount,
    required this.duelDetailsList,
  });

  @override
  List<Object> get props => [duelDetailsCount, duelDetailsList];
}
