import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/notification.dart';


class NotificationResponse extends Equatable {

  final int count;
  final List<Notification> notifications;

  const NotificationResponse({
    required this.count,
    required this.notifications,
  });

  @override
  List<Object> get props => [count, notifications];
}
