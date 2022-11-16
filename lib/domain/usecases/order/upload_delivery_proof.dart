
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/order_repository.dart';

class UploadDeliveryProof extends UseCase<Map<String, dynamic>, Params> {
  final OrderRepository _repository;

  UploadDeliveryProof(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.uploadDeliveryProof(
      orderId: params.orderParams?.orderId,
      fileType: params.orderParams?.fileType,
      file: params.orderParams?.file,
      link: params.orderParams?.link
    );
  }
}
