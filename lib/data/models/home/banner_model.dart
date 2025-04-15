import 'package:loby/domain/entities/home/home_banner.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class BannerModel extends HomeBanner {
  final int? id;

  final String? bannerName;

  final String? imageUrl;

  const BannerModel({this.id, this.bannerName, this.imageUrl});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      bannerName: json['banner_name'],
      imageUrl: json['image_url'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        bannerName,
        imageUrl,
      ];
}
