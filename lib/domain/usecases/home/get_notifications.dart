
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/home/notification_response.dart';
import 'package:loby/domain/repositories/home_repository.dart';

class GetNotifications extends UseCase<NotificationResponse, Params> {
  final HomeRepository _repository;

  GetNotifications(this._repository);

  @override
  Future<Either<Failure, NotificationResponse>> call(Params params) {

    return _repository.getNotifications(
      notificationId: params.homeParams?.notificationId,
      page: params.homeParams?.page,
    );
  }
}
