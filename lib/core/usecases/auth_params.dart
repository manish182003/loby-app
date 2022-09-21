import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AuthParams extends Equatable {
  final String search;
  final int profileID;
  final String profileType;
  final int userID;
  final File businessPicture;
  final String businessName;
  final String businessEmail;
  final List locationID;
  final List locationType;
  final List sellerNatureID;
  final String address;
  final String pinCode;
  final int incorporationYear;
  final int turnover;
  final int employeeCount;
  final String clients;
  final String website;
  final String type;
  final int cityID;
  final int enquiryID;
  final String fcmToken;
  final int amount;
  final BuildContext context;
  final dynamic gstImage;
  final int pageNo;
  final int addressID;
  final int notificationID;
  final int planId;
  final String os;
  final String orderId;
  final String status;
  final String receipt;


  const AuthParams({
    this.pageNo,
    this.notificationID,
    this.addressID,
    this.gstImage,
    this.context,
    this.fcmToken,
    this.locationID, this.locationType,
    this.cityID,
    this.type,
    this.search,
    this.profileID,
    this.profileType,
    this.userID,
    this.enquiryID,
    this.amount,
    this.planId,
    this.os,
    this.orderId,
    this.status,
    this.receipt,
    this.businessPicture, this.businessName, this.businessEmail, this.sellerNatureID, this.address, this.pinCode, this.incorporationYear, this.turnover, this.employeeCount, this.clients, this.website,
  });

  @override
  List<Object> get props => [search];
}
