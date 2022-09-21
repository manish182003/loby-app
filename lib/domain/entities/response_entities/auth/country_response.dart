import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loby/domain/entities/auth/country.dart';



class CountryResponse extends Equatable {
  final List<Country> countries;

  const CountryResponse({
    required this.countries,
  });

  @override
  List<Object> get props => [countries];
}
