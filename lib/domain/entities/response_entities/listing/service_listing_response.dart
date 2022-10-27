import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';


class ServiceListingResponse extends Equatable {

  final int count;
  final List<ServiceListing> serviceListings;

  const ServiceListingResponse({
    required this.count,
    required this.serviceListings,
  });

  @override
  List<Object> get props => [count, serviceListings];
}
