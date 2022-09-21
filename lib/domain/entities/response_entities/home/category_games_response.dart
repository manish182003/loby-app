


import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/category.dart';


class CategoryGamesResponse extends Equatable {

  final Category categoryGames;

  const CategoryGamesResponse({
    required this.categoryGames,
  });

  @override
  List<Object> get props => [categoryGames];
}
