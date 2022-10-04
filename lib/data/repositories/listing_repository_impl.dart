import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/failure.dart';
import 'package:loby/data/datasources/listing_remote_datasource.dart';
import 'package:loby/domain/entities/listing/selected_service_option.dart';
import 'package:loby/domain/entities/response_entities/listing/configuration_response.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/repositories/listing_repository.dart';

class ListingRepositoryImpl extends ListingRepository{
  final ListingRemoteDatasource _listingRemoteDatasource;

  ListingRepositoryImpl(this._listingRemoteDatasource);

  @override
  Future<Either<Failure, ConfigurationResponse>> getConfigurations({required int? categoryId, required int? gameId})async {
    try {
      return Right(await _listingRemoteDatasource.getConfigurations(categoryId, gameId));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createListing({int? categoryId, int? gameId, String? title, String? description, String? price, String? stockAvl, String? estimateDeliveryTime, int? priceUnitId, List<SelectedServiceOption>? serviceOptionId, List? files, List<int>? fileTypes, List<TextEditingController>? optionAnswer})async {
    try {
      return Right(await _listingRemoteDatasource.createListing(categoryId, gameId, title, description, price, stockAvl, estimateDeliveryTime, priceUnitId, serviceOptionId, files, fileTypes, optionAnswer ));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceListingResponse>> getBuyerListings({int? categoryId, int? gameId, int? listingId, int? userId, int? page, String? search, int? priceFrom, int? priceTo, String? sortByPrice, String? sortByRating, String? from})async {
    try {
      return Right(await _listingRemoteDatasource.getBuyerListings(categoryId, gameId, listingId, userId, page, search, priceFrom, priceTo, sortByPrice, sortByRating, from));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> reportListing({int? userId, int? userGameServiceId})async {
    try {
      return Right(await _listingRemoteDatasource.reportListing(userId, userGameServiceId));
    } on ServerException catch (e) {
      // Loggers can be added here for analyzation.
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> changeListingStatus({int? listingId, String? type})async {
    try {
      return Right(await _listingRemoteDatasource.changeListingStatus(listingId, type));
    } on ServerException catch (e) {
    // Loggers can be added here for analyzation.
    return Left(ServerFailure(message: e.message.toString()));
    }
  }


}