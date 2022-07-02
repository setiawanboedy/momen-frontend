part of 'transaction_list_cubit.dart';

enum TransStatus {
  loading,
  success,
  empty,
  failure;

  bool get isLoading => this == TransStatus.loading;

  bool get isSuccess => this == TransStatus.success;

  bool get isFailure => this == TransStatus.failure;
  bool get isEmpty => this == TransStatus.empty;
}

class TransactionListState extends Equatable {
  final TransStatus status;
  final TransactionList? transList;
  final String? message;
  final Map<String, String>? iconCategory;
  const TransactionListState({
    this.status = TransStatus.loading,
    this.transList,
    this.message,
    this.iconCategory,
  });

  TransactionListState copyWith({
    TransStatus? status,
    TransactionList? transList,
    String? message,
    Map<String, String>? iconCategory,
  }) {
    return TransactionListState(
      status: status ?? this.status,
      transList: transList ?? this.transList,
      message: message ?? this.message,
      iconCategory: iconCategory ?? this.iconCategory,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transList,
        message,
        iconCategory,
      ];
}
