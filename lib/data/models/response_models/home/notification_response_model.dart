import 'package:loby/data/models/home/notification_model.dart';
import 'package:loby/domain/entities/home/notification.dart';
import 'package:loby/domain/entities/response_entities/home/notification_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides


class NotificationResponseModel extends NotificationResponse {

  final int count;
  final List<Notification> notifications;

  const NotificationResponseModel({
    required this.count,
    required this.notifications,
  }) : super(count: count, notifications: notifications);

  @override
  List<Object> get props => [count, notifications];

  factory NotificationResponseModel.fromJSON(Map<String, dynamic> json) =>
      NotificationResponseModel(
        count: json['data']['count'],
        notifications: (json['data']['rows'] as List<dynamic>)
            .map<NotificationModel>((notification) => NotificationModel.fromJson(notification))
            .toList(),
      );
}
