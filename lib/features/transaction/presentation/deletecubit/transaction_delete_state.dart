import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction.dart';

enum TransDeleteStatus {
  loading,
  success,
  failure;

  bool get isLoading => this == TransDeleteStatus.loading;

  bool get isSuccess => this == TransDeleteStatus.success;

  bool get isFailure => this == TransDeleteStatus.failure;
}

class TransactionDeleteState extends Equatable {
  final TransDeleteStatus status;
  final Transaction? trans;
  final String? message;
  const TransactionDeleteState({
    this.status = TransDeleteStatus.loading,
    this.trans,
    this.message,
  });

  TransactionDeleteState copyWith({
    TransDeleteStatus? status,
    Transaction? trans,
    String? message,
  }) {
    return TransactionDeleteState(
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