// ignore_for_file: overridden_fields, annotate_overrides


import 'package:loby/domain/entities/auth/state.dart';
import 'package:loby/domain/entities/response_entities/auth/state_response.dart';

import '../../auth/state_model.dart';

class StateResponseModel extends StateResponse {

  final List<State> states;

  const StateResponseModel({
    required this.states,
  }) : super(states: states);

  @override
  List<Object> get props => [states];

  factory StateResponseModel.fromJSON(Map<String, dynamic> json) =>
      StateResponseModel(
        states: (json['data']['rows'] as List<dynamic>)
            .map<StateModel>((countries) => StateModel.fromJson(countries))
            .toList(),
      );
}
