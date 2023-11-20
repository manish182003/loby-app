import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/slots/delete_slots.dart';
import 'package:loby/domain/entities/slots/get_slots_for_seller.dart';

class DeleteSlotResponse extends Equatable {
  final List<DeleteSlot> deleteSlot;

  const DeleteSlotResponse({
    required this.deleteSlot
  });

  @override
  List<Object> get props => [deleteSlot];
}
