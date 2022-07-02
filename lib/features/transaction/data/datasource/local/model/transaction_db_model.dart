class TransactionDbResponse {
  TransactionDbResponse({
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

  factory TransactionDbResponse.fromJson(Map<String, dynamic> json) => TransactionDbResponse(
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

  TransactionDbResponse copy({
    int? id,
    int? userId,
    String? description,
    String? category,
    int? amount,
  }) =>
      TransactionDbResponse(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        description: description ?? this.description,
        category: category ?? this.category,
        amount: amount ?? this.amount,
      );
}

class TransFields {
  static final List<String> values = [id,userID,description,category,amount];

  static const String id = 'id';
  static const String userID = 'user_id';
  static const String description = 'description';
  static const String category = 'category';
  static const String amount = 'amount';
}
