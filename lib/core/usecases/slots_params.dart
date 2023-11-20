import 'package:equatable/equatable.dart';

class SlotsParams extends Equatable {
  final int? slotId;
  final int? sellerId;
  final int? day;
  final int? providerId;
  final String? from;
  final String? to;

  SlotsParams(
      {this.slotId,
      this.sellerId,
      this.day,
      this.providerId,
      this.from,
      this.to,});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

