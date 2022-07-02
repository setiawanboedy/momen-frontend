import 'package:dartz/dartz.dart';
import '../entities/transaction.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/trans_repository.dart';

class GetDetailTransaction extends UseCase<Transaction, TransactionIDParams> {
  final TransRepository repository;

  GetDetailTransaction(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(TransactionIDParams params) {
    return repository.getRemoteDetailTrans(params);
  }
}

class TransactionIDParams {
  final int? transID;

  TransactionIDParams({
    this.transID,
  });
}
