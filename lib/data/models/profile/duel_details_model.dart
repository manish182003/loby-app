import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/duel_details.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class DuelDetailsModel extends DuelDetails{
  const DuelDetailsModel({
    this.winCount,
    this.loseCount,
  });

  final int? winCount;
  final int? loseCount;

  factory DuelDetailsModel.fromJson(Map<String, dynamic> json) => DuelDetailsModel(
    winCount: json["win_count"],
    loseCount: json["lose_count"],
  );

  Map<String, dynamic> toJson() => {
    "win_count": winCount,
    "lose_count": loseCount,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [winCount, loseCount];
}
