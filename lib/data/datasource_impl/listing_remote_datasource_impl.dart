import 'package:dio/dio.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/datasources/listing_remote_datasource.dart';
import 'package:loby/data/models/response_models/listing/configuration_response_model.dart';
import 'package:loby/data/models/response_models/listing/service_listing_response_model.dart';
import 'package:loby/domain/entities/listing/selected_service_option.dart';

class ListingRemoteDatasourceImpl extends ListingRemoteDatasource {
  final Dio _dio;

  ListingRemoteDatasourceImpl(this._dio);

  @override
  Future<ConfigurationResponseModel> getConfigurations(
      int? categoryId, int? gameId) async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getConfigurations,
        extra: {'game_id': '$gameId', 'catgeory_id': '$categoryId'},
        headers: headers,
      );

      return ConfigurationResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> createListing(
      int? listingId,
      int? categoryId,
      int? gameId,
      String? title,
      String? description,
      String? price,
      String? stockAvl,
      String? estimateDeliveryTime,
      int? priceUnitId,
      List<SelectedServiceOption>? serviceOptionId,
      List? files,
      List<int>? fileTypes,
      String? filePathLink,
      List<TextEditingController>? optionAnswer) async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      //
      // print(listingId);
      // print(categoryId);
      // print(gameId);
      // print(title);
      // print(description);
      // print(price);
      // print(stockAvl);
      // print(estimateDeliveryTime);
      // print(priceUnitId);
      // print(serviceOptionId!.map((e) => e.id).toList().join(","));
      // print(files);
      // print(fileTypes);
      // print(optionAnswer!.map((e) => e.text).toList().join(","));
      // print(stockAvl);

      print('filePathLink $filePathLink');

      FormData formData = FormData();

      if (listingId == null) {
        formData.fields.add(
          MapEntry('category_id', "$categoryId"),
        );
        formData.fields.add(
          MapEntry('game_id', "$gameId"),
        );
        formData.fields.add(
          MapEntry('title', title!),
        );
        formData.fields.add(
          MapEntry('description', description!),
        );
        formData.fields.add(
          MapEntry('price', "$price"),
        );
        formData.fields.add(
          MapEntry('stock_avl', "$stockAvl"),
        );
        formData.fields.add(
          MapEntry('edt', "$estimateDeliveryTime"),
        );
        formData.fields.add(
          MapEntry('price_unit_id', "$priceUnitId"),
        );

        if (filePathLink != null && filePathLink.isNotEmpty) {
          formData.fields.add(
            MapEntry('file_path_link', filePathLink),
          );
        }

        if (serviceOptionId!.isNotEmpty) {
          formData.fields.add(
            MapEntry('service_option_id',
                serviceOptionId.map((e) => e.id).toList().join(",")),
          );
        }

        if (optionAnswer!.isNotEmpty) {
          formData.fields.add(MapEntry('option_answer',
              optionAnswer.map((e) => e.text).toList().join(",")));
        }
      } else {
        formData.fields.add(
          MapEntry('user_game_service_id', '$listingId'),
        );
        formData.fields.add(
          MapEntry('title', title!),
        );
        formData.fields.add(
          MapEntry('description', description!),
        );
        formData.fields.add(
          MapEntry('price', "$price"),
        );
        formData.fields.add(
          MapEntry('stock_avl', "$stockAvl"),
        );
        formData.fields.add(
          MapEntry('edt', "$estimateDeliveryTime"),
        );
        formData.fields.add(
          MapEntry('price_unit_id', "$priceUnitId"),
        );
        if (filePathLink != null && filePathLink.isNotEmpty) {
          formData.fields.add(
            MapEntry('file_path_link', filePathLink),
          );
        }
      }

      if (files!.isNotEmpty) {
        for (int i = 0; i < files.length; i++) {
          formData.files.add(MapEntry(
              listingId == null ? 'file_path' : 'file',
              MultipartFile.fromFileSync(
                files[i].path,
                // contentType: MediaType('image', 'jpg'),
              )));
        }

        formData.fields.add(
          MapEntry('type', "$fileTypes"),
        );
      }

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        listingId == null
            ? ApiEndpoints.createListing
            : ApiEndpoints.editListing,
        data: formData,
        headers: headers,
      );

      return response!['data'];
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ServiceListingResponseModel> getBuyerListings(
      int? categoryId,
      int? gameId,
      int? listingId,
      int? userId,
      int? page,
      String? search,
      int? priceFrom,
      int? priceTo,
      String? sortByPrice,
      String? sortByRating,
      String? from) async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        from == 'myProfile'
            ? ApiEndpoints.getSelfListings
            : ApiEndpoints.getBuyerListings,
        extra: {
          'category_id': '${categoryId ?? ''}',
          'game_id': '${gameId ?? ''}',
          'listing_id': '${listingId ?? ''}',
          'user_id': '${userId ?? ''}',
          'page':
              '${search != null ? '0' : listingId != null ? '0' : page ?? ''}',
          'name': search ?? '',
          'priceFrom': '${priceFrom ?? ''}',
          'priceTo': '${priceTo ?? ''}',
          'sortByPrice': sortByPrice ?? '',
          'sortByRating': sortByRating ?? '',
        },
        headers: headers,
      );

      return ServiceListingResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> reportListing(
      int? userId, int? userGameServiceId) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.reportListing,
        extra: {
          if (userId != null) 'account_id': "$userId",
          if (userGameServiceId != null)
            'user_game_service_id': "$userGameServiceId"
        },
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> changeListingStatus(
      int? listingId, String? type) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        type == 'delete' ? RequestType.delete : RequestType.post,
        type == 'delete'
            ? ApiEndpoints.deleteListing
            : ApiEndpoints.changeListingStatus,
        extra: {'user_game_service_id': "$listingId"},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> deleteListingImage(int? id, String? path) async {
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.delete,
        ApiEndpoints.deleteListingImage,
        extra: {'id': "$id", "path": path},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
