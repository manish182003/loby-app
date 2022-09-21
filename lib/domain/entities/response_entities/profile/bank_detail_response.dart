import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/bank_detail.dart';



class BankDetailResponse extends Equatable {
  final List<BankDetail> bankDetails;

  const BankDetailResponse({
    required this.bankDetails,
  });

  @override
  List<Object> get props => [bankDetails];
}
