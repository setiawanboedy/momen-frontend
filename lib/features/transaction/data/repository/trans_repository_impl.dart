import 'package:momen/features/transaction/data/datasource/local/trans_local_datasource.dart';
import 'package:momen/features/transaction/domain/usecase/update_transaction.dart';

import '../../domain/usecase/get_detail_transaction.dart';

import '../../domain/entities/transaction_list.dart';

import '../../../../core/usecase/usecase.dart';

import '../../../../core/error/exceptions.dart';
import '../datasource/remote/trans_remote_datasource.dart';
import '../../domain/entities/transaction.dart';
import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/trans_repository.dart';
import '../../domain/usecase/post_transaction.dart';

class TransRepositoryImpl implements TransRepository {
  final TransRemoteDatasource transRemoteDatasource;
  final TransLocalDatasource transLocalDatasource;

  TransRepositoryImpl(this.transRemoteDatasource, this.transLocalDatasource);

  @override
  Future<Either<Failure, Transaction>> createRemoteTrans(
      TransactionParams params) async {
    try {
      final response = await transRemoteDatasource.createTransaction(params);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TransactionList>> getRemoteAllTrans(
      NoParams params) async {
    try {
      final response = await transRemoteDatasource.getListTransactions(params);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Transaction>> getRemoteDetailTrans(
      TransactionIDParams params) async {
    try {
      final response = await transRemoteDatasource.getDetailTransaction(params);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Transaction>> deleteRemoteTrans(
      TransactionIDParams params) async {
    try {
      final response = await transRemoteDatasource.delTransacton(params);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Transaction>> updateRemoteTrans(
      TransactionUpdateParams params) async {
    try {
      final response = await transRemoteDatasource.updateTransacton(params);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> createLocalTrans(
      TransactionDBParams params) async {
    try {
      final response = await transLocalDatasource.createTransaction(params);
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
    
  }
}
