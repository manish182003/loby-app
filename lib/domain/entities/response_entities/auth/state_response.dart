

import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/auth/state.dart';

class StateResponse extends Equatable {
  final List<State> states;

  const StateResponse({
    required this.states,
  });

  @override
  List<Object> get props => [states];
}
