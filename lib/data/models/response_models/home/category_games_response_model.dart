import 'package:loby/data/models/home/category_model.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';
import 'package:loby/domain/entities/response_entities/home/category_games_response.dart';

import '../../../../domain/entities/home/category.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class CategoryGamesResponseModel extends CategoryGamesResponse {

  final Category categoryGames;

  const CategoryGamesResponseModel({
    required this.categoryGames,
  }) : super(categoryGames: categoryGames);

  @override
  List<Object> get props => [categoryGames];

  factory CategoryGamesResponseModel.fromJSON(Map<String, dynamic> json) =>
      CategoryGamesResponseModel(
        categoryGames: (CategoryModel.fromJson(json['data'])));
}
