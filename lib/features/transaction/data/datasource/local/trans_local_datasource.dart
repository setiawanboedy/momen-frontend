import 'package:momen/core/error/exceptions.dart';
import 'package:momen/features/network/db/trans_database.dart';

import '../../../domain/usecase/post_transaction.dart';

abstract class TransLocalDatasource {
  Future<int> createTransaction(TransactionDBParams params);
  
}

class TransLocalDatasourceImpl implements TransLocalDatasource {
  final TransDatabase _database;

  TransLocalDatasourceImpl(this._database);

  @override
  Future<int> createTransaction(TransactionDBParams params) async {
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
}
