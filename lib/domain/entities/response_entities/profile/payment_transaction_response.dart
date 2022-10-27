import 'package:equatable/equatable.dart';
import 'package:loby/domain/entities/profile/payment_transaction.dart';



class PaymentTransactionResponse extends Equatable {
  final int count;
  final List<PaymentTransaction> paymentTransactions;

  const PaymentTransactionResponse({
    required this.count,
    required this.paymentTransactions,
  });

  @override
  List<Object> get props => [count, paymentTransactions];
}
