import 'package:loby/data/models/home/category_model.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';
import 'package:loby/domain/entities/response_entities/home/game_category_response.dart';

import '../../../../domain/entities/home/category.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class GameCategoryResponseModel extends GameCategoryResponse {

  final List<Category> gameCategories;

  const GameCategoryResponseModel({
    required this.gameCategories,
  }) : super(gameCategories: gameCategories);

  @override
  List<Object> get props => [gameCategories];

  factory GameCategoryResponseModel.fromJSON(Map<String, dynamic> json) =>
      GameCategoryResponseModel(
        gameCategories: (json['data'] as List<dynamic>)
            .map<CategoryModel>((gameCategories) => CategoryModel.fromJson(gameCategories))
            .toList(),
      );
}
