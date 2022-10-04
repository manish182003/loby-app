import 'package:equatable/equatable.dart';

class UserGameServiceImage extends Equatable {
  const UserGameServiceImage({
    this.id,
    this.userGameServiceId,
    this.path,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userGameServiceId;
  final String? path;
  final int? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;




  @override
  // TODO: implement props
  List<Object?> get props => [id, userGameServiceId, path, type];


}
