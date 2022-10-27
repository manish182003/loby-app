import 'dart:io';

import 'package:equatable/equatable.dart';

class ProfileParams extends Equatable{

  final int? userId;
  final int? page;
  final int? amount;
  final String? signature;
  final String? paymentId;
  final String? paymentStatus;
  final String? orderId;
  final int? userGameServiceId;
  final String? insta;
  final String? youtube;
  final String? twitch;
  final String? discord;
  final String? displayName;
  final String? name;
  final String? message;
  final File? idCard;
  final File? selfie;
  final String? bankName;
  final String? branchName;
  final String? accountNumber;
  final String? confirmAccountNumber;
  final String? ifscCode;
  final String? holderName;
  final String? upiID;
  final String? type;
  final int? bankDetailId;
  final String? feedback;
  final String? email;

  const ProfileParams({
    this.email,
    this.feedback,
    this.userId, this.page, this.amount, this.signature, this.paymentId, this.paymentStatus, this.orderId, this.userGameServiceId, this.insta, this.youtube, this.twitch, this.discord,
    this.displayName, this.name, this.message, this.idCard, this.selfie,
    this.bankName, this.branchName, this.accountNumber, this.confirmAccountNumber, this.ifscCode, this.holderName, this.upiID, this.type,
    this.bankDetailId
  });

  @override

  List<Object?> get props => [userId];

}