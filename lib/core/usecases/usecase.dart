import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vyapar_dost/core/usecases/auth_params.dart';
import 'package:vyapar_dost/core/usecases/buyer_params.dart';
import 'package:vyapar_dost/core/usecases/lead_params.dart';
import 'package:vyapar_dost/core/usecases/core_params.dart';
import 'package:vyapar_dost/core/usecases/product_params.dart';
import 'package:vyapar_dost/core/usecases/profile_params.dart';

import '../utils/failure.dart';

/// Abstract UseCase class with contract to implement call method.
///
/// Implementor has to provide implementation for call() with [params].
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Custom class to hold parameters of UseCase's call().
class Params extends Equatable {
  final String token;
  final CoreParams coreParams;
  final BuyerParams buyerParams;
  final ProductParams productParams;
  final LeadParams leadParams;
  final AuthParams authParams;
  final ProfileParams profileParams;

  const Params({this.token, this.buyerParams, this.productParams, this.leadParams, this.authParams, this.coreParams, this.profileParams});

  @override
  List<Object> get props => [];
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
