import 'package:loby/core/utils/helpers.dart';

import '../../../domain/entities/home/game.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class GameModel extends Game {
  const GameModel({
    this.id,
    this.name,
    this.image,
    this.platform,
    this.createdAt,
    this.updatedAt,
    this.listingCount,
  });

  final int? id;
  final String? name;
  final String? image;
  final String? platform;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? listingCount;

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
    id: json["id"],
    name: json["name"],
    image: Helpers.getImage(json["image"]),
    platform: json["platform"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    listingCount: json["listing_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "platform": platform,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "listing_count": listingCount,
  };

  @override

  List<Object?> get props => [id, name, image, platform];
}
