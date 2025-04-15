import 'package:equatable/equatable.dart';

class HomeBanner extends Equatable {
  final int? id;
  final String? bannerName;
  final String? imageUrl;

  const HomeBanner({this.id, this.bannerName, this.imageUrl});

  @override
  List<Object?> get props => [
        id,
        bannerName,
        imageUrl,
      ];
}
