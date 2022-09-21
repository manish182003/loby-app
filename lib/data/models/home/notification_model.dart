// ignore_for_file: overridden_fields, annotate_overrides
import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/notification.dart';

class NotificationModel extends Notification{
  const NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.readStatus,
    this.status,
    this.notificationType,
    this.tablePrimaryId,
    this.tableName,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userId;
  final String? title;
  final String? message;
  final bool? readStatus;
  final int? status;
  final String? notificationType;
  final int? tablePrimaryId;
  final String? tableName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    message: json["message"],
    readStatus: json["read_status"],
    status: json["status"],
    notificationType: json["notification_type"],
    tablePrimaryId: json["table_primary_id"],
    tableName: json["table_name"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "message": message,
    "read_status": readStatus,
    "status": status,
    "notification_type": notificationType,
    "table_primary_id": tablePrimaryId,
    "table_name": tableName,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, title, message];
}
