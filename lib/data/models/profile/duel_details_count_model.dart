import 'package:loby/domain/entities/profile/duel_details_count.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class DuelDetailsCountModel extends DuelDetailsCount{
  const DuelDetailsCountModel({
    this.winCount,
    this.loseCount,
  });

  final int? winCount;
  final int? loseCount;

  factory DuelDetailsCountModel.fromJson(Map<String, dynamic> json) => DuelDetailsCountModel(
    winCount: json["win_count"],
    loseCount: json["lose_count"],
  );

  Map<String, dynamic> toJson() => {
    "win_count": winCount,
    "lose_count": loseCount,
  };

  @override
  List<Object?> get props => [winCount, loseCount];
}
