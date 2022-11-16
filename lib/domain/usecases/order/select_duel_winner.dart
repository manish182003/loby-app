
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/order_repository.dart';

class SelectDuelWinner extends UseCase<Map<String, dynamic>, Params> {
  final OrderRepository _repository;

  SelectDuelWinner(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.selectDuelWinner(
      orderId: params.orderParams?.orderId,
      winnerId: params.orderParams?.winnerId,
    );
  }
}
