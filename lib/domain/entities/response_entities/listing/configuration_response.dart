import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/listing/configuration.dart';


class ConfigurationResponse extends Equatable {
  const ConfigurationResponse({
    required this.configuration,
  });

  final Configuration configuration;

  @override
  List<Object> get props => [configuration];
}
