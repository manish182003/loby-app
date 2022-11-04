import 'package:equatable/equatable.dart';

class DuelDetailsCount extends Equatable{
  const DuelDetailsCount({
    this.winCount,
    this.loseCount,
  });

  final int? winCount;
  final int? loseCount;

  @override
  // TODO: implement props
  List<Object?> get props => [winCount, loseCount];
}
