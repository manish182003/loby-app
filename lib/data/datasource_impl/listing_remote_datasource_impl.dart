import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:loby/core/utils/constants.dart';
import 'package:loby/core/utils/exceptions.dart';
import 'package:loby/core/utils/helpers.dart';
import 'package:loby/data/datasources/listing_remote_datasource.dart';
import 'package:loby/data/models/response_models/listing/configuration_response_model.dart';
import 'package:loby/data/models/response_models/listing/service_listing_response_model.dart';
import 'package:loby/domain/entities/listing/selected_service_option.dart';

class ListingRemoteDatasourceImpl extends ListingRemoteDatasource{
  final Dio _dio;

  ListingRemoteDatasourceImpl(this._dio);

  @override
  Future<ConfigurationResponseModel> getConfigurations(int? categoryId, int? gameId)async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getConfigurations,
        queryParams: {'game_id': '$gameId', 'catgeory_id' : '$categoryId'},
        headers: headers,
      );

      return ConfigurationResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> createListing(int? categoryId, int? gameId, String? title, String? description, String? price, String? stockAvl, String? estimateDeliveryTime, int? priceUnitId, List<SelectedServiceOption>? serviceOptionId, List? files, List<int>? fileTypes, List<TextEditingController>? optionAnswer)async {
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      print(categoryId);
      print(gameId);
      print(title);
      print(description);
      print(price);
      print(stockAvl);
      print(estimateDeliveryTime);
      print(priceUnitId);
      print(serviceOptionId!.map((e) => e.id).toList().join(","));
      print(files);
      print(fileTypes);
      print(optionAnswer!.map((e) => e.text).toList().join(","));
      print(stockAvl);


      FormData formData = FormData()
        ..fields.add(
          MapEntry('category_id', "$categoryId"),
        )
        ..fields.add(
          MapEntry('game_id', "$gameId"),
        )
        ..fields.add(
          MapEntry('title', title!),
        )
        ..fields.add(
          MapEntry('description', description!),
        )
        ..fields.add(
          MapEntry('price', "$price"),
        )
        ..fields.add(
          MapEntry('stock_avl', "$stockAvl"),
        )
        ..fields.add(
          MapEntry('edt', "$estimateDeliveryTime"),
        )
        ..fields.add(
          MapEntry('price_unit_id', "$priceUnitId"),
        )
        ..fields.add(
          MapEntry('service_option_id', serviceOptionId.map((e) => e.id).toList().join(",")),
        )
        ..fields.add(
            MapEntry('option_answer', optionAnswer.map((e) => e.text).toList().join(","))
        );






      if(files!.isNotEmpty){
        for(int i = 0; i < files.length; i++){
          formData.files.add(MapEntry('file_path',
              MultipartFile.fromFileSync(files[i].path,
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
        ApiEndpoints.createListing,
        data: formData,
        headers: headers,
      );

      return response!['data'];
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ServiceListingResponseModel> getBuyerListings(int? categoryId, int? gameId, int? listingId, int? userId, int? page, String? search, int? priceFrom, int? priceTo, String? sortByPrice, String? sortByRating, String? from) async{
    try {
      String token = await Helpers.getApiToken();
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        from == 'myProfile' ? ApiEndpoints.getSelfListings : ApiEndpoints.getBuyerListings,
        queryParams: {
          'category_id': '${categoryId ?? ''}',
          'game_id' : '${gameId ?? ''}',
          'listing_id' : '${listingId ?? ''}',
          'user_id' : '${userId ?? ''}',
          'page' : '${search != null ? '0' : page ?? ''}',
          'name': search ?? '',
          'priceFrom' : '${priceFrom ?? ''}',
          'priceTo' : '${priceTo ?? ''}',
          'sortByPrice' : sortByPrice ?? '',
          'sortByRating' : sortByRating ?? '',
        },
        headers: headers,
      );

      return ServiceListingResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }


  @override
  Future<Map<String, dynamic>> reportListing(int? userId, int? userGameServiceId) async{
    try {
      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.reportListing,
        queryParams: {'account_id': "$userId", 'user_game_service_id': "$userGameServiceId"},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Map<String, dynamic>> changeListingStatus(int? listingId, String? type) async{
    try {

      print(listingId);
      print(type);

      final headers = await Helpers.getApiHeaders();
      final response = await Helpers.sendRequest(
        _dio,
        type == 'delete' ? RequestType.delete : RequestType.post,
        type == 'delete' ? ApiEndpoints.deleteListing : ApiEndpoints.changeListingStatus,
        queryParams: {'user_game_service_id': "$listingId"},
        headers: headers,
      );

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}