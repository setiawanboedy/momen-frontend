import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/transaction.dart';
import '../repository/trans_repository.dart';
import 'get_detail_transaction.dart';

class DeleteTransaction extends UseCase<Transaction, TransactionIDParams> {
  final TransRepository repository;

  DeleteTransaction(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(TransactionIDParams params) {
    return repository.deleteRemoteTrans(params);
  }
}
