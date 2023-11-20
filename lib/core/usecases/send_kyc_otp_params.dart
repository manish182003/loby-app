import 'package:equatable/equatable.dart';

class SendKycOtpParams extends Equatable {
  final String? kycToken;
  final String? aadharNumber;
  final String? type;

  SendKycOtpParams({this.kycToken , this.aadharNumber, this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
