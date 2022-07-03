
import '../../../../domain/entities/transaction.dart';
import 'transaction_response.dart';

class TransactionDeleteResponse {
    TransactionDeleteResponse({
        this.meta,
    });

    Meta? meta;
   

    factory TransactionDeleteResponse.fromJson(Map<String, dynamic> json) => TransactionDeleteResponse(
        meta: Meta.fromJson(json["meta"]),
 
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),

    };

    Transaction toEntity() => Transaction(meta: meta);
}
