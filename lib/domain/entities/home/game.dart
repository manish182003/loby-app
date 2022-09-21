import 'package:equatable/equatable.dart';

class Game extends Equatable {
  const Game({
    this.id,
    this.name,
    this.image,
    this.platform,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? image;
  final String? platform;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  @override
  // TODO: implement props
  List<Object?> get props => [id, name, image, platform];
}
