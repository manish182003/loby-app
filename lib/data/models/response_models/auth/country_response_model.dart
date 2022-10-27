// ignore_for_file: overridden_fields, annotate_overrides


import 'package:loby/data/models/auth/country_model.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';


class CountryResponseModel extends CountryResponse {

  final List<Country> countries;

  const CountryResponseModel({
    required this.countries,
  }) : super(countries: countries);

  @override
  List<Object> get props => [countries];

  factory CountryResponseModel.fromJSON(Map<String, dynamic> json) =>
      CountryResponseModel(
        countries: (json['data']['rows'] as List<dynamic>)
            .map<CountryModel>((countries) => CountryModel.fromJson(countries))
            .toList(),
      );
}
