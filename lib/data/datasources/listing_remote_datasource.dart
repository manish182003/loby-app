import 'package:flutter/cupertino.dart';
import 'package:loby/data/models/response_models/listing/configuration_response_model.dart';
import 'package:loby/domain/entities/listing/selected_service_option.dart';

import '../models/response_models/listing/service_listing_response_model.dart';

abstract class ListingRemoteDatasource{

  Future<ConfigurationResponseModel> getConfigurations(int? categoryId, int? gameId);

  Future<Map<String, dynamic>> createListing(int? listingId, int? categoryId, int? gameId, String? title, String? description, String? price, String? stockAvl, String? estimateDeliveryTime, int? priceUnitId, List<SelectedServiceOption>? serviceOptionId, List<dynamic>? files, List<int>? fileTypes, String? filePathLink, List<TextEditingController>? optionAnswer);

  Future<ServiceListingResponseModel> getBuyerListings(int? categoryId, int? gameId, int? listingId, int? userId, int? page, String? search, int? priceFrom, int? priceTo, String? sortByPrice, String? sortByRating, String? from);

  Future<Map<String, dynamic>> reportListing(int? userId, int? userGameServiceId);

  Future<Map<String, dynamic>> changeListingStatus(int? listingId, String? type);

  Future<Map<String, dynamic>> deleteListingImage(int? id, String? path);


}