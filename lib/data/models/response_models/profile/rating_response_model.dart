// ignore_for_file: overridden_fields, annotate_overrides


import 'package:flutter/cupertino.dart';
import 'package:loby/data/models/auth/city_model.dart';
import 'package:loby/data/models/auth/country_model.dart';
import 'package:loby/data/models/listing/service_listing_model.dart';
import 'package:loby/data/models/profile/rating_model.dart';
import 'package:loby/domain/entities/auth/city.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/response_entities/auth/city_response.dart';
import 'package:loby/domain/entities/response_entities/auth/country_response.dart';
import 'package:loby/domain/entities/response_entities/listing/service_listing_response.dart';
import 'package:loby/domain/entities/response_entities/profile/rating_response.dart';


class RatingResponseModel extends RatingResponse {

  final List<RatingModel> ratings;

  const RatingResponseModel({
    required this.ratings,
  }) : super(ratings: ratings);

  @override
  List<Object> get props => [ratings];

  factory RatingResponseModel.fromJSON(Map<String, dynamic> json) =>
      RatingResponseModel(
        ratings: (json['data'] as List<dynamic>)
            .map<RatingModel>((ratings) => RatingModel.fromJson(ratings))
            .toList(),
      );
}
