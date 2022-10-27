import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/auth/city.dart';



class CityResponse extends Equatable {
  final List<City> cities;

  const CityResponse({
    required this.cities,
  });

  @override
  List<Object> get props => [cities];
}
