// ignore_for_file: overridden_fields, annotate_overrides
import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/bank_detail.dart';

class BankDetailModel extends BankDetail{
  const BankDetailModel({
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

  factory BankDetailModel.fromJson(Map<String, dynamic> json) => BankDetailModel(
    id: json["id"],
    bankName: json["bank_name"],
    branchName: json["branch_name"],
    fullRegisteredName: json["full_registered_name"],
    ifscCode: json["ifsc_code"],
    bankAccountNumber: json["bank_account_number"],
    bankAccountType: json["bank_account_type"],
    userId: json["user_id"],
    upiId: json["upi_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank_name": bankName,
    "branch_name": branchName,
    "full_registered_name": fullRegisteredName,
    "ifsc_code": ifscCode,
    "bank_account_number": bankAccountNumber,
    "bank_account_type": bankAccountType,
    "user_id": userId,
    "upi_id": upiId,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, fullRegisteredName, bankAccountNumber];
}
