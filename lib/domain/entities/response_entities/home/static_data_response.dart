


import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/static_data.dart';


class StaticDataResponse extends Equatable {

  final List<StaticData> staticData;

  const StaticDataResponse({
    required this.staticData,
  });

  @override
  List<Object> get props => [staticData];
}
