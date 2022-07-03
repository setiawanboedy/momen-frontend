part of 'transaction_list_cubit.dart';

enum TransListStatus {
  loading,
  success,
  empty,
  failure;

  bool get isLoading => this == TransListStatus.loading;

  bool get isSuccess => this == TransListStatus.success;

  bool get isFailure => this == TransListStatus.failure;
  bool get isEmpty => this == TransListStatus.empty;
}

class TransactionListState extends Equatable {
  final TransListStatus status;
  final TransactionList? transList;
  final String? message;
  final int? totalAmount;
  final Map<String, String>? iconCategory;
  const TransactionListState({
    this.status = TransListStatus.loading,
    this.transList,
    this.totalAmount,
    this.message,
    this.iconCategory,
  });

  TransactionListState copyWith({
    TransListStatus? status,
    TransactionList? transList,
    int? totalAmount,
    String? message,
    Map<String, String>? iconCategory,
  }) {
    return TransactionListState(
      status: status ?? this.status,
      transList: transList ?? this.transList,
      totalAmount: totalAmount ?? this.totalAmount,
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
