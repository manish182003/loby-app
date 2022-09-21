import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loby/domain/entities/auth/city.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/listing/configuration.dart';
import 'package:loby/domain/entities/listing/game_category_service.dart';
import 'package:loby/domain/entities/listing/unit.dart';


class ConfigurationResponse extends Equatable {
  const ConfigurationResponse({
    required this.configuration,
  });

  final Configuration configuration;

  @override
  List<Object> get props => [configuration];
}
