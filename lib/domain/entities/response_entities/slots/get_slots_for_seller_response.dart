import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/slots/get_slots_for_seller.dart';

class GetSlotsForSellerResponse extends Equatable {
  final List<GetSlotsForSeller> getSlotForSeller;

  const GetSlotsForSellerResponse({
    required this.getSlotForSeller
  });

  @override
  List<Object> get props => [getSlotForSeller];
}
