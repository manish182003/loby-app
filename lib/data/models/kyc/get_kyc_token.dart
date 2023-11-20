// ignore_for_file: overridden_fields, annotate_overrides


import 'package:loby/domain/entities/kyc/get_kyc_token.dart';

class KycTokenModel extends GetKycToken {
  const KycTokenModel(
      {this.kycToken,});

  final String? kycToken;

  factory KycTokenModel.fromJson(Map<String, dynamic> json) => KycTokenModel(
        kycToken: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": kycToken,
      };

  @override
  List<Object?> get props =>
      [];
}
