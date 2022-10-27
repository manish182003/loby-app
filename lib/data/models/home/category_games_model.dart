import 'package:loby/domain/entities/home/category_games.dart';
import 'game_model.dart';
// ignore_for_file: overridden_fields, annotate_overrides



class CategoryGamesModel extends CategoryGames{
  const CategoryGamesModel({
    this.id,
    this.gameId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.game,
  });

  final int? id;
  final int? gameId;
  final int? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final GameModel? game;

  factory CategoryGamesModel.fromJson(Map<String, dynamic> json) => CategoryGamesModel(
    id: json["id"],
    gameId: json["game_id"],
    categoryId: json["category_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    game: GameModel.fromJson(json["game"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "game_id": gameId,
    "category_id": categoryId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "game": game?.toJson(),
  };

  @override

  List<Object?> get props => [id, gameId, categoryId, game];
}