import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:loby/data/models/profile/user_model.dart';
import 'package:loby/data/models/home/category_model.dart';
import 'package:loby/data/models/home/game_model.dart';
import 'package:loby/data/models/listing/unit_model.dart';
import 'package:loby/data/models/listing/user_game_service_image_model.dart';
import 'package:loby/data/models/listing/user_game_service_option_model.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/listing/unit.dart';
import 'package:loby/domain/entities/listing/user_game_service_image.dart';
import 'package:loby/domain/entities/listing/user_game_service_option.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class ServiceListingModel extends ServiceListing{
  ServiceListingModel({
    this.id,
    this.categoryId,
    this.gameId,
    this.title,
    this.description,
    this.price,
    this.stockAvl,
    this.edt,
    this.userId,
    this.priceUnitId,
    this.status,
    this.listingNumber,
    this.shareableLink,
    this.createdAt,
    this.updatedAt,
    this.userGameServiceImages,
    this.userGameServiceOptions,
    this.user,
    this.game,
    this.category,
    this.unit,
  });

  final int? id;
  final int? categoryId;
  final int? gameId;
  final String? title;
  final String? description;
  final int? price;
  final int? stockAvl;
  final int? edt;
  final int? userId;
  final int? priceUnitId;
  String? status;
  final String? listingNumber;
  final String? shareableLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<UserGameServiceImageModel>? userGameServiceImages;
  final List<UserGameServiceOptionModel>? userGameServiceOptions;
  final UserModel? user;
  final GameModel? game;
  final CategoryModel? category;
  final UnitModel? unit;

  factory ServiceListingModel.fromJson(Map<String, dynamic> json) => ServiceListingModel(
    id: json["id"],
    categoryId: json["category_id"],
    gameId: json["game_id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    stockAvl: json["stock_avl"],
    edt: json["edt"],
    userId: json["user_id"],
    priceUnitId: json["price_unit_id"],
    status: json["status"],
    listingNumber: json["listing_number"],
    shareableLink: json["shareable_link"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    userGameServiceImages: json["userGameServiceImages"] == null ? null : List<UserGameServiceImageModel>.from(json["userGameServiceImages"].map((x) => UserGameServiceImageModel.fromJson(x))),
    userGameServiceOptions: json["userGameServiceOptions"] == null ? null : List<UserGameServiceOptionModel>.from(json["userGameServiceOptions"].map((x) => UserGameServiceOptionModel.fromJson(x))),
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
    game: json["game"] == null ? null : GameModel.fromJson(json["game"]),
    category: json["category"] == null ? null : CategoryModel.fromJson(json["category"]),
    unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "game_id": gameId,
    "title": title,
    "description": description,
    "price": price,
    "stock_avl": stockAvl,
    "edt": edt,
    "user_id": userId,
    "price_unit_id": priceUnitId,
    "status": status,
    "listing_number": listingNumber,
    "shareable_link": shareableLink,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userGameServiceImages": userGameServiceImages == null ? null : List<dynamic>.from(userGameServiceImages!.map((x) => x.toJson())),
    "userGameServiceOptions": userGameServiceOptions == null ? null : List<dynamic>.from(userGameServiceOptions!.map((x) => x.toJson())),
    "user": user?.toJson(),
    "game": game?.toJson(),
    "category": category?.toJson(),
    "unit": unit?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, categoryId, gameId, title];
}
