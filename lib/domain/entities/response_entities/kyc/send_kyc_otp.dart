import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/kyc/get_kyc_token.dart';
import 'package:loby/domain/entities/kyc/send_kyc_otp.dart';
import 'package:loby/domain/entities/slots/get_slots_for_buyer.dart';
import 'package:loby/domain/entities/slots/get_slots_for_seller.dart';

class SendKycOtpResponse extends Equatable {
  final SendKycOtp sendKycOtp;

  const SendKycOtpResponse({
    required this.sendKycOtp
  });

  @override
  List<Object> get props => [sendKycOtp];
}