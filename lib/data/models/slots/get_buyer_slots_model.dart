import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/response_entities/slots/get_slots_for_seller_response.dart';
import 'package:loby/domain/entities/slots/get_slots_for_buyer.dart';
import 'package:loby/domain/entities/slots/get_slots_for_seller.dart';

class GetBuyerSlotsModel extends GetSlotsForBuyer {
  @override
  final int? sellerId;
  final int? id;
  final String? from;
  final String? to;
  final UserModel? userDetail;
  final int? day;
  final String? isBooked;
  // final DateTime? createdAt;
  // final DateTime? updatedAt;

  const GetBuyerSlotsModel(
      {required this.sellerId,
      required this.id,
      required this.from,
      required this.day,
      required this.to,
      required this.isBooked,
      required this.userDetail
      // required this.createdAt,
      // required this.updatedAt,
      });

  factory GetBuyerSlotsModel.fromJson(Map<String, dynamic> json) =>
      GetBuyerSlotsModel(
        day: json["day"],
        from: json["from"],
        sellerId: json["seller_id"],
        id: json["id"],
        to: json["to"],
        isBooked: json["isBooked"],
        userDetail: json['user'] == null ? null : UserModel.fromJson(json['user']),
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "from": from,
        "seller_id": sellerId,
        "id": id,
        "to": to,
        "isBooked": isBooked,
        "user": userdetail,
        // "createdAt": createdAt?.toIso8601String(),
        // "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [day, sellerId];
}
