import 'package:equatable/equatable.dart';

class Notification extends Equatable{
  const Notification({
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


  @override
  List<Object?> get props => [id, userId, title, message];
}
