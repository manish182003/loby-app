import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/service_option.dart';

class GameCategoryServiceOption extends Equatable {
  const GameCategoryServiceOption({
    this.id,
    this.serviceOption,
  });

  final int? id;
  final ServiceOption? serviceOption;

  @override
  List<Object?> get props => [id, serviceOption];
}