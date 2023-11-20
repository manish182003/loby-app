import 'package:equatable/equatable.dart';

class VerifyKycOtpParams extends Equatable {
  final String? kycToken;
  final String? otp;
  final String? refId;

  VerifyKycOtpParams({this.kycToken , this.otp, this.refId});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
