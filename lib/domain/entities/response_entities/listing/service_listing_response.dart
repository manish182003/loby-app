import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';


class ServiceListingResponse extends Equatable {

  final int count;
  final List<ServiceListing> serviceListings;
  final int maxFilterPrice;

  const ServiceListingResponse({
    required this.count,
    required this.serviceListings,
    required this.maxFilterPrice,
  });

  @override
  List<Object> get props => [count, serviceListings, maxFilterPrice];
}
