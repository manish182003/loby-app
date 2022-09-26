import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/domain/entities/listing/selected_service_option.dart';
import 'package:loby/domain/entities/response_entities/listing/configuration_response.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';

abstract class ListingRepository{

  Future<Either<Failure, ConfigurationResponse>> getConfigurations({required int? categoryId, required int? gameId});

  Future<Either<Failure, Map<String, dynamic>>> createListing({int? categoryId, int? gameId, String? title, String? description, String? price, String? stockAvl, String? estimateDeliveryTime, int? priceUnitId, List<SelectedServiceOption>? serviceOptionId, List<dynamic>? files, List<int>? fileTypes, List<TextEditingController>? optionAnswer});

  Future<Either<Failure, ServiceListingResponse>> getBuyerListings({int? categoryId, int? gameId, int? listingId, int? userId, int? page, String? search, int? priceFrom, int? priceTo, String? sortByPrice, String? sortByRating});

  Future<Either<Failure, Map<String, dynamic>>> reportListing({int? userId, int? userGameServiceId});




}



