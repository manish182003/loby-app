


import 'package:equatable/equatable.dart';

import '../../home/game.dart';

class GameResponse extends Equatable {

  final List<Game> games;

  const GameResponse({
    required this.games,
  });

  @override
  List<Object> get props => [games];
}
