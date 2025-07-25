import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service.dart';

import 'game_category_service_option.dart';

class GameCategoryService extends Equatable {
  const GameCategoryService({
    this.id,
    this.service,
    this.gameCategoryServiceOptions,
  });

  final int? id;
  final Service? service;
  final List<GameCategoryServiceOption>? gameCategoryServiceOptions;


  @override
  List<Object?> get props => [id, service, gameCategoryServiceOptions];
}