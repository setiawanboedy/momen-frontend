import '../../../../domain/entities/transaction.dart';

class TransactionResponse {
  TransactionResponse({
    this.meta,
    this.data,
  });

  Meta? meta;
  Data? data;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
        meta: Meta.fromJson(json["meta"] ?? {}),
        data: Data.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
      };

  Transaction toEntity() => Transaction(data: data, meta: meta);
}

class Data {
  Data({
    this.id,
    this.userId,
    this.description,
    this.category,
    this.amount,
  });

  int? id;
  int? userId;
  String? description;
  String? category;
  int? amount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        description: json["description"],
        category: json["category"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "description": description,
        "category": category,
        "amount": amount,
      };
}

class Meta {
  Meta({
    this.message,
    this.code,
    this.status,
  });

  String? message;
  int? code;
  String? status;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "status": status,
      };
}

class TransFields {
  static final List<String> values = [id,userID,description,category,amount];

  static const String id = 'id';
  static const String userID = 'user_id';
  static const String description = 'description';
  static const String category = 'category';
  static const String amount = 'amount';
}