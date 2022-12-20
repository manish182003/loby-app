// ignore_for_file: overridden_fields, annotate_overrides
import 'package:loby/data/models/listing/service_listing_model.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';

class ServiceListingResponseModel extends ServiceListingResponse {

  final int count;
  final List<ServiceListing> serviceListings;
  final int maxFilterPrice;

  const ServiceListingResponseModel({
    required this.count,
    required this.serviceListings,
    required this.maxFilterPrice,
  }) : super(count: count, serviceListings: serviceListings, maxFilterPrice: maxFilterPrice);

  @override
  List<Object> get props => [count, serviceListings];

  factory ServiceListingResponseModel.fromJSON(Map<String, dynamic> json) =>
      ServiceListingResponseModel(
        count: json['data']['count'] ?? 0,
        serviceListings: json['data']['rows'] == null ? [ServiceListingModel.fromJson(json['data'])] :  (json['data']['rows'] as List<dynamic>)
            .map<ServiceListingModel>((listings) => ServiceListingModel.fromJson(listings)).toList(),
        maxFilterPrice: json["maxPrice"] ?? 0,
      );
}
