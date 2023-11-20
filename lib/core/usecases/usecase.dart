import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:loby/core/usecases/auth_params.dart';
import 'package:loby/core/usecases/buyer_slots_Params.dart';
import 'package:loby/core/usecases/edit_slot_params.dart';
import 'package:loby/core/usecases/get_kyc_token_params.dart';
import 'package:loby/core/usecases/home_params.dart';
import 'package:loby/core/usecases/listing_params.dart';
import 'package:loby/core/usecases/profile_params.dart';
import 'package:loby/core/usecases/send_kyc_otp_params.dart';
import 'package:loby/core/usecases/slots_params.dart';
import 'package:loby/core/usecases/delete_slot_params.dart';
import 'package:loby/core/usecases/buyer_slots_params.dart' as buyer;
import 'package:loby/core/usecases/verify_kyc_otp.dart';
import '../utils/failure.dart';
import 'chat_params.dart';
import 'order_params.dart';

/// Abstract UseCase class with contract to implement call method.
///
/// Implementor has to provide implementation for call() with [params].
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Custom class to hold parameters of UseCase's call().
class Params extends Equatable {
  final String? token;
  final AuthParams? authParams;
  final HomeParams? homeParams;
  final ChatParams? chatParams;
  final OrderParams? orderParams;
  final ListingParams? listingParams;
  final ProfileParams? profileParams;
  final SlotsParams? slotsParams;
  final BuyerParams? buyerSlotsParams;
  final DeleteSlotsParams? deleteSlotsParams;
  final KycTokenParams? kycTokenParams;
  final SendKycOtpParams? sendKycOtpParams;
  final VerifyKycOtpParams? verifyKycOtpParams;
  final EditSlotParams? editSlotParams;

  const Params({
    this.token,
    this.authParams,
    this.homeParams,
    this.chatParams,
    this.listingParams,
    this.profileParams,
    this.orderParams,
    this.slotsParams,
    this.buyerSlotsParams,
    this.deleteSlotsParams,
    this.kycTokenParams,
    this.sendKycOtpParams,
    this.verifyKycOtpParams,
    this.editSlotParams,
  });

  @override
  List<Object> get props => [];
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
