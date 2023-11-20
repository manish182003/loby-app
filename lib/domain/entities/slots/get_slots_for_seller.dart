import 'package:equatable/equatable.dart';

class GetSlotsForSeller extends Equatable {
  const GetSlotsForSeller(
      {this.sellerId, this.slotId, this.from, this.to, this.day});

  final int? sellerId;
  final int? slotId;
  final String? from;
  final String? to;
  final int? day;
  
  @override
  // TODO: implement props
  List<Object?> get props => [sellerId, slotId, day];


}
