// import 'package:loby/data/models/order/order_model.dart';
import 'package:loby/data/models/slots/get_slots_model.dart';
// import 'package:loby/domain/entities/response_entities/order/order_response.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides


class GetSlotResponseModel extends GetSlotsForSellerResponse {

  final List<GetSlotsModel> getSlots;

  const GetSlotResponseModel({
    required this.getSlots,
  }) : super(getSlotForSeller: getSlots);

  @override
  List<Object> get props => [getSlots];

  factory GetSlotResponseModel.fromJSON(Map<String, dynamic> json) =>
      GetSlotResponseModel(
        getSlots: (json['data'] as List<dynamic>)
            .map<GetSlotsModel>((slots) => GetSlotsModel.fromJson(slots))
            .toList(),
      );
}