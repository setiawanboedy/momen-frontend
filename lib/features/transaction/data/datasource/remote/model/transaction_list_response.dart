import '../../../../domain/entities/transaction_list.dart';

import 'transaction_response.dart';


class TransactionListResponse {
  TransactionListResponse({
    this.meta,
    this.totalTransaction,
    this.data,
  });

  Meta? meta;
  int? totalTransaction;
  List<Data>? data;

  factory TransactionListResponse.fromJson(Map<String, dynamic> json) =>
      TransactionListResponse(
        meta: Meta.fromJson(json["meta"]),
        totalTransaction: json["total_transaction"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "total_transaction": totalTransaction,
        "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
      };

  TransactionList toEntity() => TransactionList(meta?.message, data, totalTransaction);
}
