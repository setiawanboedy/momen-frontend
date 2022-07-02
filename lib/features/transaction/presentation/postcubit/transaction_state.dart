part of 'transaction_cubit.dart';

enum TransStatus {
  loading,
  success,
  failure;

  bool get isLoading => this == TransStatus.loading;

  bool get isSuccess => this == TransStatus.success;

  bool get isFailure => this == TransStatus.failure;
}

class TransactionState extends Equatable {
  final TransStatus status;
  final Transaction? trans;
  final String? message;
  const TransactionState({
    this.status = TransStatus.loading,
    this.trans,
    this.message,
  });

  TransactionState copyWith({
    TransStatus? status,
    Transaction? trans,
    String? message,
  }) {
    return TransactionState(
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
