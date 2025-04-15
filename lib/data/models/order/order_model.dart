// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/data/models/listing/service_listing_model.dart';
import 'package:loby/data/models/order/review_model.dart';
import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/domain/entities/order/order.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

import 'dispute_model.dart';
import 'order_status_model.dart';

class OrderModel extends Order {
  const OrderModel({
    this.id,
    this.userGameServiceId,
    this.userId,
    this.disputeId,
    this.quantity,
    this.price,
    this.cronUpdatedTime,
    this.paymentSettlement,
    this.transactionFreeze,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.userGameService,
    this.dispute,
    this.orderStatuses,
    this.slotId,
    this.bookfromtime,
    this.booktotime,
    this.bookDate,
    this.ratingReviews,
  });

  final int? id;
  final int? userGameServiceId;
  final int? userId;
  final int? disputeId;
  final int? quantity;
  final int? price;
  final String? bookfromtime;
  final String? booktotime;
  final String? bookDate;
  final DateTime? cronUpdatedTime;
  final String? paymentSettlement;
  final String? transactionFreeze;
  final int? slotId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? user;
  final ReviewModel? ratingReviews;
  final ServiceListingModel? userGameService;
  final DisputeModel? dispute;
  final List<OrderStatusModel>? orderStatuses;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    logger.i(
        "rating and reviews-> ${json['ratingsReview']} ordername->${json['userGameService']}");
    return OrderModel(
      id: json["id"],
      userGameServiceId: json["user_game_service_id"],
      userId: json["user_id"],
      disputeId: json["dispute_id"],
      quantity: json["quantity"],
      price: json["price"],
      bookfromtime: json["booked_from_time"].toString(),
      booktotime: json["booked_to_time"].toString(),
      bookDate: json["booked_date"],
      cronUpdatedTime: json["cron_updated_time"] == null
          ? null
          : DateTime.parse(json["cron_updated_time"]),
      paymentSettlement: json["payment_settlement"],
      transactionFreeze: json["transaction_freeze"],
      slotId: json["slot_id"] == null ? null : int.tryParse(json["slot_id"]),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      user: json['user'] == null ? null : UserModel.fromJson(json['user']),
      userGameService: json["userGameService"] == null
          ? null
          : ServiceListingModel.fromJson(json["userGameService"]),
      dispute: json['dispute'] == null
          ? null
          : DisputeModel.fromJson(json["dispute"]),
      orderStatuses: json["orderStatuses"] == null
          ? null
          : List<OrderStatusModel>.from(
              json["orderStatuses"].map((x) => OrderStatusModel.fromJson(x))),
      ratingReviews: json['ratingsReview'] == null
          ? null
          : ReviewModel.fromJSON(
              json['ratingsReview'],
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_game_service_id": userGameServiceId,
        "user_id": userId,
        "dispute_id": disputeId,
        "quantity": quantity,
        "price": price,
        "booked_from_time": bookfromtime,
        "booked_to_time": booktotime,
        "booked_date": bookDate,
        "cron_updated_time": cronUpdatedTime,
        "payment_settlement": paymentSettlement,
        "transaction_freeze": transactionFreeze,
        "slot_id": slotId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "userGameService": userGameService?.toJson(),
        "orderStatuses":
            List<dynamic>.from(orderStatuses!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        id,
        userGameServiceId,
        userId,
        createdAt,
        disputeId,
        slotId,
        quantity,
        bookfromtime,
        booktotime,
        bookDate
      ];
}
