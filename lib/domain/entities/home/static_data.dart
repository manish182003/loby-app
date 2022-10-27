import 'package:equatable/equatable.dart';

class StaticData extends Equatable{
  const StaticData({
    this.id,
    this.key,
    this.realValue,
    this.label,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? key;
  final String? realValue;
  final String? label;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  @override
  List<Object?> get props => [id, key, realValue, label];
}
