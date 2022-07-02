import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction.dart';

enum TransDetailStatus {
  loading,
  success,
  failure;

  bool get isLoading => this == TransDetailStatus.loading;

  bool get isSuccess => this == TransDetailStatus.success;

  bool get isFailure => this == TransDetailStatus.failure;
}

class TransactionDetailState extends Equatable {
  final TransDetailStatus status;
  final Transaction? trans;
  final String? message;
  const TransactionDetailState({
    this.status = TransDetailStatus.loading,
    this.trans,
    this.message,
  });

  TransactionDetailState copyWith({
    TransDetailStatus? status,
    Transaction? trans,
    String? message,
  }) {
    return TransactionDetailState(
      status: status ?? this.status,
      trans: trans ?? this.trans,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        trans,
        message,
      ];
}