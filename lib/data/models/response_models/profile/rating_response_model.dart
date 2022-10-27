// ignore_for_file: overridden_fields, annotate_overrides


import 'package:loby/data/models/profile/rating_model.dart';
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
        ratings: (json['data']['rows'] as List<dynamic>)
            .map<RatingModel>((ratings) => RatingModel.fromJson(ratings))
            .toList(),
      );
}
