import 'package:momen/core/usecase/usecase.dart';
import 'package:momen/features/transaction/data/datasource/remote/model/transaction_list_response.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../network/db/trans_database.dart';

import '../../../domain/usecase/post_transaction.dart';

abstract class TransLocalDatasource {
  Future<int> createDBTransaction(TransactionParams params);
  Future<TransactionListResponse> getAllDBTransaction(NoParams params);
}

class TransLocalDatasourceImpl implements TransLocalDatasource {
  final TransDatabase _database;

  TransLocalDatasourceImpl(this._database);

  @override
  Future<int> createDBTransaction(TransactionParams params) async {
    try {
      final response = await _database.createTrans(params);
      if (response != 0) {
        return response;
      } else {
        throw CacheException("not found");
      }
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<TransactionListResponse> getAllDBTransaction(
      NoParams params) async {
    try {
      final response = await _database.getAllTrans(params);
      return response;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
