import 'package:equatable/equatable.dart';
import '../../data/datasource/remote/model/transaction_response.dart';

class Transaction extends Equatable {
  final Data? data;
  final Meta? meta;

  const Transaction({this.data, this.meta});
  @override
  List<Object?> get props => [data, meta];
}
