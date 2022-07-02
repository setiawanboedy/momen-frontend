import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/transaction_list.dart';

import '../../../../core/usecase/usecase.dart';
import '../repository/trans_repository.dart';

class GetTransactionList extends UseCase<TransactionList, NoParams> {
  final TransRepository repository;

  GetTransactionList(this.repository);

  @override
  Future<Either<Failure, TransactionList>> call(NoParams params) {
    return repository.getRemoteAllTrans(params);
  }
}
