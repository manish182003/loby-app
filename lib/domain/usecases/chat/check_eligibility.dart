
import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/repositories/chat_repository.dart';

class CheckEligibility extends UseCase<Map<String, dynamic>, Params> {
  final ChatRepository _repository;

  CheckEligibility(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.checkEligibility(
      receiverId: params.chatParams?.receiverId,
    );
  }
}
