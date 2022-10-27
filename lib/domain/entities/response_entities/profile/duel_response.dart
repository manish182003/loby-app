import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/duel_details.dart';



class DuelResponse extends Equatable {
  final DuelDetails duelDetails;

  const DuelResponse({
    required this.duelDetails,
  });

  @override
  List<Object> get props => [duelDetails];
}
