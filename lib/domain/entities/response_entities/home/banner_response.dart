import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/home/home_banner.dart';

class BannerResponse extends Equatable {
  final List<HomeBanner> banners;
  const BannerResponse({
    required this.banners,
  });
  @override
  List<Object?> get props => [banners];
}
