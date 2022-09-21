import 'package:equatable/equatable.dart';

class DuelDetails extends Equatable{
  const DuelDetails({
    this.winCount,
    this.loseCount,
  });

  final int? winCount;
  final int? loseCount;

  @override
  // TODO: implement props
  List<Object?> get props => [winCount, loseCount];
}
