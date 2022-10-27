
import 'package:equatable/equatable.dart';

class HomeParams extends Equatable {
  final String? name;
  final int? page;
  final int? categoryId;
  final int? gameId;
  final int? listingId;
  final int? quantity;
  final String? price;
  final String? search;
  final int? orderId;
  final String? status;
  final int? notificationId;
  final String? type;


  const HomeParams( {
    this.type,
    this.orderId, this.status,
    this.name,
    this.page,
    this.categoryId,
    this.gameId,
    this.listingId, this.quantity, this.price, this.search,
    this.notificationId,
  });

  @override
  List<Object> get props => [];
}
