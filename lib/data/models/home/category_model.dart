import 'package:equatable/equatable.dart';
import 'package:loby/data/models/home/category_games_model.dart';
import 'package:loby/domain/entities/home/category.dart';

import '../../../domain/entities/home/category.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class CategoryModel extends Category{
  const CategoryModel({
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
  final List<CategoryGamesModel>? categoryGames;


  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    disclaimer: json["disclaimer"],
    commissionPercent: json["commission_percent"],
    quantitySelection: json["quantity_selection"],
    uniqueCode: json["unique_code"],
    lobyCoinsPercent: json["loby_coins_percent"],
    govtCommission: json["govt_commission"],
    edtDays: json["edt_days"],
    settlementTypes: json["settlement_types"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    categoryGames: json["gameCategories"] == null ? null :  List<CategoryGamesModel>.from(json["gameCategories"].map((x) => CategoryGamesModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "disclaimer": disclaimer,
    "commission_percent": commissionPercent,
    "quantity_selection": quantitySelection,
    "unique_code": uniqueCode,
    "loby_coins_percent": lobyCoinsPercent,
    "govt_commission": govtCommission,
    "edt_days": edtDays,
    "settlement_types": settlementTypes,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, categoryGames];
}
