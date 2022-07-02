import 'package:dartz/dartz.dart';
import 'package:momen/features/transaction/domain/usecase/update_transaction.dart';
import '../usecase/get_detail_transaction.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/transaction_list.dart';
import '../entities/transaction.dart';
import '../usecase/post_transaction.dart';

import '../../../../core/failure/failure.dart';

abstract class TransRepository {
  Future<Either<Failure, Transaction>> createRemoteTrans(
      TransactionParams params);
  Future<Either<Failure, TransactionList>> getRemoteAllTrans(NoParams params);
  Future<Either<Failure, Transaction>> getRemoteDetailTrans(
      TransactionIDParams params);
  Future<Either<Failure, Transaction>> deleteRemoteTrans(
      TransactionIDParams params);
  Future<Either<Failure, Transaction>> updateRemoteTrans(
      TransactionUpdateParams params);

  Future<Either<Failure, int>> createLocalTrans(
      TransactionDBParams params);
}
