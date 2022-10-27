
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:loby/domain/entities/listing/selected_service_option.dart';

class ListingParams extends Equatable {
  final int? categoryId;
  final int? gameId;
  final String? title;
  final String? description;
  final String? price;
  final String? stockAvl;
  final String? estimateDeliveryTime;
  final int? priceUnitId;
  final List<SelectedServiceOption>? serviceOptionId;
  final List<PlatformFile>? files;
  final List<int>? fileTypes;
  final List<TextEditingController>? optionAnswer;
  final int? listingId;
  final int? userId;
  final int? page;
  final int? userGameServiceId;
  final String? search;
  final int? priceFrom;
  final int? priceTo;
  final String? sortByPrice;
  final String? sortByRating;
  final String? from;
  final String? type;




  const ListingParams({
    this.priceFrom, this.priceTo, this.sortByPrice, this.sortByRating,
    this.categoryId,
    this.gameId,
    this.listingId,
    this.userId,
    this.page,
    this.title, this.description, this.price, this.stockAvl, this.estimateDeliveryTime, this.priceUnitId, this.serviceOptionId, this.files, this.fileTypes, this.optionAnswer,
    this.userGameServiceId,
    this.search,
    this.from,
    this.type
  });

  @override
  List<Object> get props => [];
}
