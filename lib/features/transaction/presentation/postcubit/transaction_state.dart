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
  final int? transID;
  final String? message;
  const TransactionState({
    this.status = TransStatus.loading,
    this.transID,
    this.message,
  });

  TransactionState copyWith({
    TransStatus? status,
    int? transID,
    String? message,
  }) {
    return TransactionState(
      status: status ?? this.status,
      transID: transID ?? this.transID,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transID,
        message,
      ];
}
