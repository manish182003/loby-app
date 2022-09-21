import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/user.dart';

class Chat extends Equatable{
  const Chat({
    this.id,
    this.senderId,
    this.receiverId,
    this.badgeCount,
    this.chatLatestDate,
    this.chatLatestMessage,
    this.senderInfo,
    this.receiverInfo,
  });

  final int? id;
  final int? senderId;
  final int? receiverId;
  final int? badgeCount;
  final DateTime? chatLatestDate;
  final String? chatLatestMessage;
  final User? senderInfo;
  final User? receiverInfo;


  @override
  // TODO: implement props
  List<Object?> get props => [id, senderId, receiverId, badgeCount];
}