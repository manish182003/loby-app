import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/slots/get_slots_for_buyer.dart';
import 'package:loby/domain/entities/slots/get_slots_for_seller.dart';

class GetSlotsForBuyerResponse extends Equatable {
  final List<GetSlotsForBuyer> getSlotForBuyer;

  const GetSlotsForBuyerResponse({
    required this.getSlotForBuyer
  });

  @override
  List<Object> get props => [getSlotForBuyer];
}