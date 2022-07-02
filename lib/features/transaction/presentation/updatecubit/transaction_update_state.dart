import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction.dart';

enum TransUpdateStatus {
  loading,
  success,
  failure;

  bool get isLoading => this == TransUpdateStatus.loading;

  bool get isSuccess => this == TransUpdateStatus.success;

  bool get isFailure => this == TransUpdateStatus.failure;
}

class TransactionUpdateState extends Equatable {
  final TransUpdateStatus status;
  final Transaction? trans;
  final String? message;
  const TransactionUpdateState({
    this.status = TransUpdateStatus.loading,
    this.trans,
    this.message,
  });

  TransactionUpdateState copyWith({
    TransUpdateStatus? status,
    Transaction? trans,
    String? message,
  }) {
    return TransactionUpdateState(
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