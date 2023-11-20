import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/order_repository.dart';

class CreateOrder extends UseCase<Map<String, dynamic>, Params> {
  final OrderRepository _repository;

  CreateOrder(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    print("params.orderParams?.bookDate >>> ${params.orderParams?.bookDate}");
    return _repository.createOrder(
        listingId: params.orderParams?.listingId,
        quantity: params.orderParams?.quantity,
        price: params.orderParams?.price,
        bookDate: params.orderParams?.bookDate,
        bookFromTime: params.orderParams?.bookFromTime,
        bookToTime: params.orderParams?.bookToTime);
  }
}
