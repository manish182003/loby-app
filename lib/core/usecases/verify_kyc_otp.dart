import 'package:equatable/equatable.dart';

class VerifyKycOtpParams extends Equatable {
  final String? kycToken;
  final String? otp;
  final String? refId;
  final String? aadharNum;

  VerifyKycOtpParams({this.kycToken , this.otp, this.refId, this.aadharNum});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
