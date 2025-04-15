import 'package:loby/data/models/home/banner_model.dart';
import 'package:loby/domain/entities/home/home_banner.dart';
import 'package:loby/domain/entities/response_entities/home/banner_response.dart';

// ignore_for_file: overridden_fields, annotate_overrides
class BannerResponseModel extends BannerResponse {
  final List<HomeBanner> banners;

  const BannerResponseModel({required this.banners})
      : super(
          banners: banners,
        );

  @override
  List<Object?> get props => [banners];

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) {
    return BannerResponseModel(
      banners: json['data'] == null
          ? []
          : (json['data'] as List<dynamic>)
              .map<BannerModel>((banner) => BannerModel.fromJson(banner))
              .toList(),
    );
  }
}
