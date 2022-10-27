import 'package:equatable/equatable.dart';

import 'game.dart';

class CategoryGames extends Equatable{
  const CategoryGames({
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
  final Game? game;

  @override
  List<Object?> get props => [id, gameId, categoryId, game];
}