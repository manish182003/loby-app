import 'package:equatable/equatable.dart';

class EditSlotParams extends Equatable {
  final int? slotId;
  final int? orderId;
  final String? date;

  EditSlotParams({
    this.date,
    this.orderId,
    this.slotId
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
