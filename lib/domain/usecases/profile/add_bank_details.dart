import 'package:dartz/dartz.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/entities/response_entities/profile/duel_response.dart';
import 'package:loby/domain/entities/response_entities/profile/user_response.dart';
import 'package:loby/domain/repositories/listing_repository.dart';
import 'package:loby/domain/repositories/profile_repository.dart';

class AddBankDetails extends UseCase<Map<String, dynamic>, Params> {
  final ProfileRepository _repository;

  AddBankDetails(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) {
    return _repository.addBankDetails(
      bankName: params.profileParams?.bankName,
      branchName: params.profileParams?.branchName,
      accountNumber: params.profileParams?.accountNumber,
      confirmAccountNumber: params.profileParams?.confirmAccountNumber,
      ifscCode: params.profileParams?.ifscCode,
      holderName: params.profileParams?.holderName,
      upiId: params.profileParams?.upiID,
      type: params.profileParams?.type,
    );
  }
}
