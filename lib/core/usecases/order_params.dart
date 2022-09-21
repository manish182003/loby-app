import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class OrderParams extends Equatable {

  final int? listingId;
  final int? quantity;
  final String? price;
  final int? orderId;
  final int? winnerId;
  final String? status;
  final List<int>? fileType;
  final List<File>? file;
  final double? stars;
  final String? review;


  const OrderParams({
    this.orderId, this.status,
    this.listingId, this.quantity, this.price,
    this.fileType, this.file, this.stars, this.review, this.winnerId
  });

  @override
  List<Object> get props => [];
}
