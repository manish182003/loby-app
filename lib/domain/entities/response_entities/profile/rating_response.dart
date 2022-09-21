import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loby/domain/entities/auth/country.dart';
import 'package:loby/domain/entities/listing/service_listing.dart';
import 'package:loby/domain/entities/profile/rating.dart';



class RatingResponse extends Equatable {
  final List<Rating> ratings;

  const RatingResponse({
    required this.ratings,
  });

  @override
  List<Object> get props => [ratings];
}
