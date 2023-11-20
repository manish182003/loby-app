import 'package:loby/data/models/kyc/get_kyc_token.dart';
import 'package:loby/domain/entities/response_entities/kyc/get_kyc_token.dart';

class GetKycResponseModel extends GetKycTokenResponse {

  final KycTokenModel getKyc;

  const GetKycResponseModel({
    required this.getKyc
    ,
  }) : super(getKycToken: getKyc);

  @override
  List<Object> get props => [getKyc];

  factory GetKycResponseModel.fromJSON(Map<String, dynamic> json) =>
      GetKycResponseModel(
        getKyc: (json['token'])
            ,
      );
}