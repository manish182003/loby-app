import 'package:equatable/equatable.dart';

import 'game_category_service.dart';
import 'unit.dart';

class Configuration extends Equatable{
  const Configuration({
    this.gameCategoryServices,
    this.units,
    this.maximumEstimatedDeliveryTimeDays,
  });

  final List<GameCategoryService>? gameCategoryServices;
  final List<Unit>? units;
  final String? maximumEstimatedDeliveryTimeDays;


  @override
  List<Object?> get props => [gameCategoryServices, units, maximumEstimatedDeliveryTimeDays];
}