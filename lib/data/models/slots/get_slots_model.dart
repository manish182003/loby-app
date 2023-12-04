// import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';
import 'package:loby/domain/entities/slots/get_slots_for_seller.dart';

class GetSlotsModel extends GetSlotsForSeller {
  final int? sellerId;
  final int? slotId;
  final String? from;
  final String? to;
  final int? day;
  // final DateTime? createdAt;
  // final DateTime? updatedAt;
  

  const GetSlotsModel({
    required this.sellerId,
    required this.slotId,
    required this.from,
    required this.day,
    required this.to,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory GetSlotsModel.fromJson(Map<String, dynamic> json) => GetSlotsModel(
    day: json["day"],
    from: json["from"],
    sellerId: json["seller_id"],
    slotId: json["id"],
    to: json["to"],
    // createdAt: DateTime.parse(json["createdAt"]),
    // updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "day" : day,
    "from" : from,
    "seller_id" : sellerId,
    "id" : slotId,
    "to" : to,
    // "createdAt": createdAt?.toIso8601String(),
    // "updatedAt": updatedAt?.toIso8601String(),
    
  };

  @override
  List<Object?> get props => [day, sellerId, slotId];
}