import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loby/core/usecases/listing_params.dart';
import 'package:loby/core/usecases/usecase.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/domain/entities/listing/configuration.dart';
import 'package:loby/domain/entities/listing/selected_service_option.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/listing/user_game_service_image.dart';
import 'package:loby/domain/usecases/listing/create_listing.dart';
import 'package:loby/domain/usecases/listing/get_buyer_listings.dart';
import 'package:loby/domain/usecases/listing/get_configurations.dart';
import 'package:loby/domain/usecases/listing/report_listing.dart';

import '../../../domain/usecases/listing/change_listing_status.dart';
import '../../../domain/usecases/listing/delete_listing_image.dart';

class ListingController extends GetxController{
  final GetConfigurations _getConfigurations;
  final CreateListing _createListing;
  final GetBuyerListings _getBuyerListings;
  final ReportListing _reportListing;
  final ChangeListingStatus _changeListingStatus;
  final DeleteListingImage _deleteListingImage;


  ListingController({
    required GetConfigurations getConfigurations,
    required CreateListing createListing,
    required GetBuyerListings getBuyerListings,
    required ReportListing reportListing,
    required ChangeListingStatus changeListingStatus,
    required DeleteListingImage deleteListingImage,
  }) : _getConfigurations = getConfigurations,
        _createListing = createListing,
  _getBuyerListings = getBuyerListings,
  _reportListing = reportListing,
  _changeListingStatus = changeListingStatus,
  _deleteListingImage = deleteListingImage;


  final errorMessage = ''.obs;


  Configuration configuration = const Configuration();
  final isServicesAvailable = false.obs;

  final title = TextEditingController().obs;
  final description = TextEditingController().obs;
  final price = TextEditingController().obs;
  final stockAvl = TextEditingController().obs;
  final estimateDeliveryTime = ''.obs;
  final priceUnitId = 0.obs;
  final serviceOptionId = <SelectedServiceOption>[].obs;
  final files = <PlatformFile>[].obs;
  final fileTypes = <int>[].obs;
  final filePathLink = TextEditingController().obs;
  final optionAnswer = <TextEditingController>[].obs;

  final downloadedListingFiles = <UserGameServiceImage>[].obs;


  final buyerListings = <ServiceListing>[].obs;
  final buyerSingleListing = ServiceListing().obs;
  final isBuyerListingsFetching = false.obs;
  final areMoreListingAvailable = true.obs;
  final buyerListingPageNumber = 1.obs;

  final buyerListingsProfile = <ServiceListing>[].obs;

  final quantityCount = 1.obs;
  final totalPrice = "".obs;


  final categoryId = 0.obs;
  final maxFilterPrice = 0.obs;

  final rangeSliderDiscreteValues = const RangeValues(0, 235000).obs;

  final tokenToRupee = "0".obs;
  final rupeeToToken = "0".obs;






  Future<bool> getConfigurations({required int? categoryId, required int? gameId}) async {

    final failureOrSuccess = await _getConfigurations(
      Params(listingParams: ListingParams(
        categoryId: categoryId,
        gameId: gameId
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
            configuration = success.configuration;
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  Future<bool> createListing({int? listingId, int? categoryId, int? gameId}) async {

    final failureOrSuccess = await _createListing(
      Params(listingParams: ListingParams(
        listingId: listingId,
          categoryId: categoryId,
          gameId: gameId,
          title: title.value.text,
          description: description.value.text,
          price: price.value.text,
          stockAvl: stockAvl.value.text,
          estimateDeliveryTime: estimateDeliveryTime.value,
          priceUnitId: priceUnitId.value,
          serviceOptionId: serviceOptionId,
          files: files,
          fileTypes: fileTypes,
          filePathLink: filePathLink.value.text,
          optionAnswer: optionAnswer,


      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
            clearListing();
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


  void clearListing(){


    title.value.clear();
    description.value.clear();
    price.value.clear();
    stockAvl.value.clear();
    estimateDeliveryTime.value = "";
    priceUnitId.value = 0;
    serviceOptionId.clear();
    files.clear();
    fileTypes.clear();
    optionAnswer.clear();
    filePathLink.value.clear();
    isServicesAvailable.value = false;

    downloadedListingFiles.clear();

    tokenToRupee.value = "0";
    rupeeToToken.value = "0";

  }



  Future<bool> getBuyerListings({int? categoryId, int? gameId, int? listingId, int? userId, String? search, String? from, int? priceFrom, int? priceTo, String? sortByPrice, String? sortByRating}) async {
    // print(buyerListingPageNumber);
    // print(isBuyerListingsFetching);
    // print(areMoreListingAvailable);

    buyerListingPageNumber.value == 1 ? isBuyerListingsFetching(true) : isBuyerListingsFetching(false);


    if(areMoreListingAvailable.value){
      final failureOrSuccess = await _getBuyerListings(
        Params(listingParams: ListingParams(
          categoryId: categoryId,
          gameId: gameId,
          listingId: listingId,
          userId: userId,
          page: buyerListingPageNumber.value,
          search: search,
          priceFrom: priceFrom,
          priceTo: priceTo,
          sortByRating: sortByRating,
          sortByPrice: sortByPrice,
          from: from
        ),),
      );

      failureOrSuccess.fold(
            (failure) {
          errorMessage.value = Helpers.convertFailureToMessage(failure);
          debugPrint(errorMessage.value);
          Helpers.toast(errorMessage.value);
          isBuyerListingsFetching.value = false;
        },
            (success) {


              if(listingId != null){
                buyerSingleListing.value = success.serviceListings.first;
                areMoreListingAvailable.value = false;
              }else{

                if(from == 'other' || from == 'myProfile'){
                  areMoreListingAvailable.value = success.serviceListings.length == 10;
                  if (buyerListingPageNumber > 1) {
                    buyerListingsProfile.addAll(success.serviceListings);
                  } else {
                    buyerListingsProfile.value = success.serviceListings;
                  }

                }else{
                  maxFilterPrice.value = success.maxFilterPrice;
                  log("'${success.maxFilterPrice}', '${success.serviceListings}'");
                  areMoreListingAvailable.value = success.serviceListings.length == 10;
                  if (buyerListingPageNumber > 1) {
                    buyerListings.addAll(success.serviceListings);
                  } else {
                    buyerListings.value = success.serviceListings;
                  }
                }}


              buyerListingPageNumber.value++;
              debugPrint("Are More Listing Available $areMoreListingAvailable");
              debugPrint("page $buyerListingPageNumber");

              isBuyerListingsFetching.value = false;
        },
      );
      return failureOrSuccess.isRight() ? true : false;
    }
    return false;
  }

  Future<bool> reportListing({int? userId, int? userGameServiceId}) async {

    final failureOrSuccess = await _reportListing(
      Params(listingParams: ListingParams(
        userId: userId,
        userGameServiceId: userGameServiceId
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {
            Helpers.toast(userId == null ? "Listing Successfully Reported." : "Account Successfully Reported");
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> changeListingStatus({required int listingId, required String type}) async {

    final failureOrSuccess = await _changeListingStatus(
      Params(listingParams: ListingParams(
          listingId: listingId,
        type: type,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> deleteListingImage({required int id, required String path}) async {

    final failureOrSuccess = await _deleteListingImage(
      Params(listingParams: ListingParams(
        imageId: id,
        imagePath: path,
      ),),
    );

    failureOrSuccess.fold(
          (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
          (success) {

      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }


}