import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/transaction.dart';
import '../repository/trans_repository.dart';

class UpdateTransaction extends UseCase<Transaction, TransactionUpdateParams> {
  final TransRepository repository;

  UpdateTransaction(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(TransactionUpdateParams params) {
    return repository.updateRemoteTrans(params);
  }
}

class TransactionUpdateParams {
  final int? transID;
  final String? description;
  final String? category;
  final int? amount;

  TransactionUpdateParams({
    this.transID,
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
