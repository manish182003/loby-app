import 'package:equatable/equatable.dart';

class SendKycOtp extends Equatable {
  const SendKycOtp({this.kycToken, this.aadharNumber, this.type});

  final String? kycToken;
  final String? aadharNumber;
  final String? type;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
