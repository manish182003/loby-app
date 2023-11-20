import 'package:equatable/equatable.dart';

class GetSlotsForBuyer extends Equatable {
  const GetSlotsForBuyer(
      {this.sellerId, this.id, this.from, this.to, this.day, this.isBooked});

  final int? sellerId;
  final int? id;
  final String? from;
  final String? to;
  final int? day;
  final String? isBooked;

  @override
  // TODO: implement props
  List<Object?> get props => [sellerId, id, day];
}
