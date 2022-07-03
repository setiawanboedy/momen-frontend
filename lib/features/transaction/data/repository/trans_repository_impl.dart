import 'package:momen/di/di.dart';
import 'package:momen/features/auth/data/datasources/local/auth_pref_manager.dart';

import '../../../../core/network/network_info.dart';
import '../datasource/local/trans_local_datasource.dart';
import '../../domain/usecase/update_transaction.dart';
import '../../../../utils/common.dart';

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
  final NetworkInfo networkInfo;

  TransRepositoryImpl(
    this.transRemoteDatasource,
    this.transLocalDatasource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, TransactionList>> getRemoteAllTrans(
      NoParams params) async {
    if (await networkInfo.isConnected) {
      /// logic update

      return _getAllDB(params);
    } else {
      return _getAllDB(params);
    }
  }

  @override
  Future<Either<Failure, int>> loadFromDBtoAPI(NoParams params) async {
    final allDB = await _getAllDB(params);
    final allApi = await transRemoteDatasource.getListTransactions(params);
    final listTrans = allApi.data;

    allDB.fold((l) {
      CacheFailure(l.toString());
    }, (r) {
      r.transList?.forEach((db) {
        listTrans?.forEach((api) async {
          if (db.id != null && db.id != api.id) {
            await transRemoteDatasource.createTransaction(
              TransactionParams(
                transID: db.id,
                description: db.description,
                category: db.category,
                amount: db.amount,
              ),
            );
          }
        });
      });
    });
    return const Right(0);
  }

  Future<Either<Failure, TransactionList>> _getAllDB(NoParams params) async {
    try {
      final response = await transLocalDatasource.getAllDBTransaction(params);
      return Right(response.toEntity());
    } on CacheException catch (e) {
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
  Future<Either<Failure, int>> createRemoteTrans(
      TransactionParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final transID = await _createDBTrans(params);
        int? id;
        transID.fold((l) {
          CacheFailure(l.toString());
        }, (r) async {
          await transRemoteDatasource.createTransaction(
            TransactionParams(
              transID: r,
              description: params.description,
              category: params.category,
              amount: params.amount,
            ),
          );
          id = r;
        });

        return Right(id ?? 0);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return _createDBTrans(params);
    }
  }

  Future<Either<Failure, int>> _createDBTrans(TransactionParams params) async {
    try {
      final response = await transLocalDatasource.createDBTransaction(
        TransactionParams(
          userID: sl<AuthPrefManager>().userID,
          description: params.description,
          category: params.category,
          amount: params.amount,
        ),
      );
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> loadFromAPItoDB(NoParams params) async {
    final allApi = await transRemoteDatasource.getListTransactions(params);
    final listTrans = allApi.data;
    listTrans?.forEach((api) async {
      if (api.id != null) {
        await _createDBTrans(
          TransactionParams(
            transID: api.id,
            userID: api.userId,
            description: api.description,
            category: api.category,
            amount: api.amount,
          ),
        );
      } 
    });
    return const Right(0);
  }
}
