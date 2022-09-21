import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/profile/duel_details.dart';
import 'package:loby/domain/entities/profile/user.dart';



class DuelResponse extends Equatable {
  final DuelDetails duelDetails;

  const DuelResponse({
    required this.duelDetails,
  });

  @override
  List<Object> get props => [duelDetails];
}
