import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/order/order.dart';

import '../profile/user.dart';

class Message extends Equatable{
  const Message({
    this.id,
    this.chatChannelId,
    this.userId,
    this.message,
    this.filePath,
    this.fileType,
    this.readStatus,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.userOrder,
    this.user,
  });

  final int? id;
  final int? chatChannelId;
  final int? userId;
  final String? message;
  final String? filePath;
  final int? fileType;
  final bool? readStatus;
  final int? orderId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Order? userOrder;
  final User? user;


  @override
  // TODO: implement props
  List<Object?> get props => [id, chatChannelId, userId, message];
}
