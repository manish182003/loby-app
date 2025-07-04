
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/home_repository.dart';

class DeleteNotification extends UseCase<Map<String, dynamic>, Params> {
  final HomeRepository _repository;

  DeleteNotification(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.deleteNotification(
      notificationId: params.homeParams?.notificationId,
    );
  }
}
