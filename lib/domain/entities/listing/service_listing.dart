

// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/user.dart';
import 'package:loby/domain/entities/home/category.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:loby/domain/entities/listing/unit.dart';
import 'package:loby/domain/entities/listing/user_game_service_image.dart';
import 'package:loby/domain/entities/listing/user_game_service_option.dart';

class ServiceListing extends Equatable{
  ServiceListing({
    this.id,
    this.categoryId,
    this.gameId,
    this.title,
    this.description,
    this.price,
    this.stockAvl,
    this.quantity = 1,
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
  int? stockAvl;
  int quantity;
  final int? edt;
  final int? userId;
  final int? priceUnitId;
  String? status;
  final String? listingNumber;
  final String? shareableLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<UserGameServiceImage>? userGameServiceImages;
  final List<UserGameServiceOption>? userGameServiceOptions;
  final User? user;
  final Game? game;
  final Category? category;
  final Unit? unit;


  @override
  List<Object?> get props => [id, categoryId, gameId, title];
}
