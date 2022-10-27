import 'package:loby/data/models/home/game_model.dart';
import 'package:loby/domain/entities/home/game.dart';
import 'package:loby/domain/entities/response_entities/home/game_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides


class GameResponseModel extends GameResponse {

  final List<Game> games;

  const GameResponseModel({
    required this.games,
  }) : super(games: games);

  @override
  List<Object> get props => [games];

  factory GameResponseModel.fromJSON(Map<String, dynamic> json) =>
      GameResponseModel(
        games: (json['data']['rows'] as List<dynamic>)
            .map<GameModel>((games) => GameModel.fromJson(games))
            .toList(),
      );
}
