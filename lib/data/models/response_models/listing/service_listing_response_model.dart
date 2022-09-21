// ignore_for_file: overridden_fields, annotate_overrides


import 'package:flutter/cupertino.dart';
import 'package:loby/data/models/auth/city_model.dart';
import 'package:loby/data/models/auth/country_model.dart';
import 'package:loby/data/models/listing/service_listing_model.dart';
import 'package:loby/domain/entities/auth/city.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/response_entities/auth/city_response.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';


class ServiceListingResponseModel extends ServiceListingResponse {

  final int count;
  final List<ServiceListing> serviceListings;

  const ServiceListingResponseModel({
    required this.count,
    required this.serviceListings,
  }) : super(count: count, serviceListings: serviceListings);

  @override
  List<Object> get props => [count, serviceListings];

  factory ServiceListingResponseModel.fromJSON(Map<String, dynamic> json) =>
      ServiceListingResponseModel(
        count: json['data']['count'],
        serviceListings: (json['data']['rows'] as List<dynamic>)
            .map<ServiceListingModel>((listings) => ServiceListingModel.fromJson(listings))
            .toList(),
      );
}
