import '../../../domain/usecase/update_transaction.dart';

import 'model/transaction_delete_response.dart';
import '../../../domain/usecase/get_detail_transaction.dart';

import '../../../../../core/usecase/usecase.dart';
import 'model/transaction_list_response.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../network/api/dio_client.dart';
import '../../../../network/api/list_api.dart';
import '../../../domain/usecase/post_transaction.dart';
import 'model/transaction_response.dart';

abstract class TransRemoteDatasource {
  Future<int> createTransaction(TransactionParams params);
  Future<TransactionListResponse> getListTransactions(NoParams params);
  Future<TransactionResponse> getDetailTransaction(TransactionIDParams params);
  Future<TransactionDeleteResponse> delTransacton(TransactionIDParams params);
  Future<TransactionResponse> updateTransacton(TransactionUpdateParams params);
}

class TransRemoteDatasourceImpl implements TransRemoteDatasource {
  final DioClient _client;

  TransRemoteDatasourceImpl(this._client);

  @override
  Future<int> createTransaction(
      TransactionParams params) async {
    try {
      final response = await _client.postRequest(
        ListApi.createTransApi,
        data: params.toJsonApi(),
      );
      final result = TransactionResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return result.data?.id ?? 0;
      } else {
        throw ServerException(result.meta?.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<TransactionListResponse> getListTransactions(NoParams params) async {
    try {
      final response = await _client.getRequest(ListApi.listTransApi);
      final result = TransactionListResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return result;
      } else {
        throw ServerException(result.meta?.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<TransactionResponse> getDetailTransaction(
      TransactionIDParams params) async {
    try {
      String transID = '${params.transID}';
      final response =
          await _client.getRequest(ListApi.detailTransApi + transID);
      final result = TransactionResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return result;
      } else {
        throw ServerException(result.meta?.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
  
  @override
  Future<TransactionDeleteResponse> delTransacton(TransactionIDParams params) async {
    try {
      String transID = '${params.transID}';
      final response =
          await _client.deleteRequest(ListApi.deleteTransApi + transID);
      final result = TransactionDeleteResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return result;
      } else {
        throw ServerException(result.meta?.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
  
  @override
  Future<TransactionResponse> updateTransacton(TransactionUpdateParams params) async {
    try {
      String transID = '${params.transID}';
      final response =
          await _client.updateRequest(ListApi.updateTransApi + transID, data: params.toJson());
      final result = TransactionResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        return result;
      } else {
        throw ServerException(result.meta?.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
