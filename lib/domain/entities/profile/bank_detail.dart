import 'package:equatable/equatable.dart';

class BankDetail extends Equatable{
  const BankDetail({
    this.id,
    this.bankName,
    this.branchName,
    this.fullRegisteredName,
    this.ifscCode,
    this.bankAccountNumber,
    this.bankAccountType,
    this.userId,
    this.upiId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? bankName;
  final String? branchName;
  final String? fullRegisteredName;
  final String? ifscCode;
  final String? bankAccountNumber;
  final String? bankAccountType;
  final int? userId;
  final String? upiId;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  @override
  // TODO: implement props
  List<Object?> get props => [id, fullRegisteredName, bankAccountNumber];
}
