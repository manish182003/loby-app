


import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/home/game_category.dart';

class GameCategoryResponse extends Equatable {

  final List<Category> gameCategories;

  const GameCategoryResponse({
    required this.gameCategories,
  });

  @override
  List<Object> get props => [gameCategories];
}
