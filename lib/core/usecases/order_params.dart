import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class OrderParams extends Equatable {
  final int? listingId;
  final int? quantity;
  final String? price;
  final int? orderId;
  final int? winnerId;
  final String? status;
  final String? bookFromTime;
  final String? bookToTime;
  final String? bookDate;
  final List<int>? fileType;
  final List<File>? file;
  final double? stars;
  final String? review;
  final String? description;
  final int? page;
  final int? disputeId;
  final List<PlatformFile>? files;
  final List<int>? fileTypes;
  final String? link;
  final bool? isUpdatingTime;

  const OrderParams({
    this.orderId,
    this.status,
    this.bookFromTime,
    this.bookToTime,
    this.bookDate,
    this.listingId,
    this.quantity,
    this.price,
    this.fileType,
    this.file,
    this.stars,
    this.review,
    this.winnerId,
    this.description,
    this.page,
    this.disputeId,
    this.files,
    this.fileTypes,
    this.link,
    this.isUpdatingTime,
  });

  @override
  List<Object> get props => [];
}
