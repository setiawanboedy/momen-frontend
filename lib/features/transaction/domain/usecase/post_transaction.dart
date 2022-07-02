import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/transaction.dart';
import '../repository/trans_repository.dart';

class PostTransaction extends UseCase<Transaction, TransactionParams> {
  final TransRepository repository;

  PostTransaction(this.repository);
  @override
  Future<Either<Failure, Transaction>> call(TransactionParams params) {
    return repository.createRemoteTrans(params);
  }
}

class TransactionParams {
  final String? description;
  final String? category;
  final int? amount;

  TransactionParams({
    this.description,
    this.category,
    this.amount,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'category': category,
        'amount': amount,
      };
}

class TransactionDBParams {
  final int? transID;
  final int? userID;
  final String? description;
  final String? category;
  final int? amount;

  TransactionDBParams({
    this.transID,
    this.userID,
    this.description,
    this.category,
    this.amount,
  });

  Map<String, dynamic> toJson() => {
        'id': transID,
        'user_id': userID,
        'description': description,
        'category': category,
        'amount': amount,
      };
}
