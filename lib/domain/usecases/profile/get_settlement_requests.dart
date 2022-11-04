import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/profile/settlement_request_response.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class GetSettlementRequests extends UseCase<SettlementRequestResponse, Params> {
  final ProfileRepository _repository;

  GetSettlementRequests(this._repository);

  @override
  Future<Either<Failure, SettlementRequestResponse>> call(Params params) {
    return _repository.getSettlementRequests(
      page: params.profileParams?.page,
      type: params.profileParams?.type,
    );
  }
}
