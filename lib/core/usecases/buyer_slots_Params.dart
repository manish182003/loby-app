import 'package:equatable/equatable.dart';

class BuyerParams extends Equatable {
  final int? id;
  final int? sellerId;
  final int? day;
  final int? providerId;
  final String? from;
  final String? to;
  final String? date;
  final String? isBooked;

  BuyerParams({
    this.id,
    this.sellerId,
    this.day,
    this.providerId,
    this.from,
    this.to,
    this.date,
    this.isBooked,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
