import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/profile/duel_response.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class GetDuel extends UseCase<DuelResponse, Params> {
  final ProfileRepository _repository;

  GetDuel(this._repository);

  @override
  Future<Either<Failure, DuelResponse>> call(Params params) {
    return _repository.getDuel(
      userId: params.profileParams?.userId,
    );
  }
}
