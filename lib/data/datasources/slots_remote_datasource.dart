// import 'package:loby/data/models/slots/get_buyer_slots_model.dart';
// import 'package:loby/data/models/response_models/slots/get_slots_response.dart';
// import 'package:loby/domain/entities/response_entities/slots/delete_slot.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_buyer.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';

abstract class SlotsRemoteDatasource {
  Future<Map<String, dynamic>> addSlots(
      int? slotId, int? day, String? from, String? to);

  Future<GetSlotsForSellerResponse> getSlots(
    // int? slotId,
    int? day,
    int? providerId,  
  );

  Future<GetSlotsForBuyerResponse> getBuyerSlots(
    String? date,
    int? providerId,
  );

  Future<Map<String,dynamic>> deleteSlots(
    int? slotId, 
  );

  Future<Map<String,dynamic>> editSlots(
    String? date,
    int? orderId,
    int? slotId
  );

}
