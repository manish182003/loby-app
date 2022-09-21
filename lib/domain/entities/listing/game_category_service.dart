import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service.dart';

class GameCategoryService extends Equatable {
  const GameCategoryService({
    this.id,
    this.service,
  });

  final int? id;
  final Service? service;


  @override
  // TODO: implement props
  List<Object?> get props => [id, service];
}