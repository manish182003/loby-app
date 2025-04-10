// import 'package:loby/data/models/order/order_model.dart';
import 'package:loby/data/models/slots/get_buyer_slots_model.dart';
// import 'package:loby/data/models/slots/get_slots_model.dart';
// import 'package:loby/domain/entities/response_entities/order/order_response.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_buyer.dart';
// import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides

class GetBuyerSlotResponseModel extends GetSlotsForBuyerResponse {
  final List<GetBuyerSlotsModel> getBuyerSlots;

  const GetBuyerSlotResponseModel({
    required this.getBuyerSlots,
  }) : super(getSlotForBuyer: getBuyerSlots);

  @override
  List<Object> get props => [getBuyerSlots];

  factory GetBuyerSlotResponseModel.fromJSON(Map<String, dynamic> json) =>
      GetBuyerSlotResponseModel(
        getBuyerSlots: json['data'] == null
            ? []
            : (json['data'] as List<dynamic>)
                .map<GetBuyerSlotsModel>(
                    (buyerslots) => GetBuyerSlotsModel.fromJson(buyerslots))
                .toList(),
      );
}
