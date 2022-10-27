// ignore_for_file: overridden_fields, annotate_overrides

import 'package:loby/domain/entities/order/dispute_proof.dart';

class DisputeProofModel extends DisputeProof{
  const DisputeProofModel({
    this.id,
    this.userOrderId,
    this.disputeId,
    this.filePath,
    this.fileType,
    this.description,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userOrderId;
  final int? disputeId;
  final String? filePath;
  final int? fileType;
  final String? description;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory DisputeProofModel.fromJson(Map<String, dynamic> json) => DisputeProofModel(
    id: json["id"],
    userOrderId: json["user_order_id"],
    disputeId: json["dispute_id"],
    filePath: json["file_path"],
    fileType: json["file_type"],
    description: json["description"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_order_id": userOrderId,
    "dispute_id": disputeId,
    "file_path": filePath,
    "file_type": fileType,
    "description": description,
    "user_id": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  List<Object?> get props => [id, userOrderId, disputeId];
}
