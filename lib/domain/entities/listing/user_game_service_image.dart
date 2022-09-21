import 'package:equatable/equatable.dart';

class UserGameServiceImage extends Equatable {
  const UserGameServiceImage({
    this.id,
    this.userGameServiceId,
    this.path,
    this.type,
  });

  final int? id;
  final int? userGameServiceId;
  final String? path;
  final int? type;




  @override
  // TODO: implement props
  List<Object?> get props => [id, userGameServiceId, path, type];


}
