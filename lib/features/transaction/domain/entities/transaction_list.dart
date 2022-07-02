import 'package:equatable/equatable.dart';

import '../../data/datasource/remote/model/transaction_response.dart';

class TransactionList extends Equatable {
  final String? message;
  final List<Data>? transList;
  final int? totalAmount;

  const TransactionList(this.message, this.transList, this.totalAmount);
  @override
  List<Object?> get props => [message, transList];
}
