import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:loby/domain/entities/home/category_games.dart';


class Category extends Equatable{
  const Category({
    this.id,
    this.name,
    this.disclaimer,
    this.commissionPercent,
    this.quantitySelection,
    this.uniqueCode,
    this.lobyCoinsPercent,
    this.govtCommission,
    this.edtDays,
    this.settlementTypes,
    this.createdAt,
    this.updatedAt,
    this.categoryGames,
  });

  final int? id;
  final String? name;
  final String? disclaimer;
  final int? commissionPercent;
  final int? quantitySelection;
  final String? uniqueCode;
  final int? lobyCoinsPercent;
  final dynamic govtCommission;
  final String? edtDays;
  final int? settlementTypes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CategoryGames>? categoryGames;



  @override
  // TODO: implement props
  List<Object?> get props => [id, name, categoryGames];
}
