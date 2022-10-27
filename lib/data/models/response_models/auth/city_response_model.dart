// ignore_for_file: overridden_fields, annotate_overrides


import 'package:loby/data/models/auth/city_model.dart';
import 'package:loby/domain/entities/auth/city.dart';
import 'package:loby/domain/entities/response_entities/auth/city_response.dart';


class CityResponseModel extends CityResponse {

  final List<City> cities;

  const CityResponseModel({
    required this.cities,
  }) : super(cities: cities);

  @override
  List<Object> get props => [cities];

  factory CityResponseModel.fromJSON(Map<String, dynamic> json) =>
      CityResponseModel(
        cities: (json['data']['rows'] as List<dynamic>)
            .map<CityModel>((countries) => CityModel.fromJson(countries))
            .toList(),
      );
}
