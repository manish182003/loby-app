import 'package:loby/data/models/listing/configuration_model.dart';
import 'package:loby/domain/entities/response_entities/listing/configuration_response.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class ConfigurationResponseModel extends ConfigurationResponse {
  const ConfigurationResponseModel({
    required this.configuration,
  }) : super(configuration: configuration);

  final ConfigurationModel configuration;

  factory ConfigurationResponseModel.fromJSON(Map<String, dynamic> json) =>
      ConfigurationResponseModel(
        configuration: ConfigurationModel.fromJson(json['data']),
      );

  @override
  List<Object> get props => [configuration];
}
