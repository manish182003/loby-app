import 'package:equatable/equatable.dart';

class DeleteSlot extends Equatable {
  const DeleteSlot(
      {this.slotId});

  final int? slotId;
  
  @override
  // TODO: implement props
  List<Object?> get props => [slotId];


}