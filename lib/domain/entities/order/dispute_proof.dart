import 'package:equatable/equatable.dart';

class DisputeProof extends Equatable{
  const DisputeProof({
    this.id,
    this.userOrderId,
    this.disputeId,
    this.filePath,
    this.fileType,
    this.description,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userOrderId;
  final int? disputeId;
  final String? filePath;
  final int? fileType;
  final String? description;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  // TODO: implement props
  List<Object?> get props => [id, userOrderId, disputeId];
}
