
import '../../../../../core/error/exceptions.dart';
import '../../../../network/api/dio_client.dart';
import '../../../../network/api/list_api.dart';
import '../../../domain/usecase/post_login.dart';
import '../../../domain/usecase/post_register.dart';
import 'model/login_response.dart';
import 'model/register_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginParams loginParams);
  Future<RegisterResponse> register(RegisterParams registerParams);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<LoginResponse> login(LoginParams loginParams) async {
    try {
      final response = await _client.postRequest(
        ListApi.login,
        data: loginParams.toJson(),
      );
      final result = LoginResponse.fromJson(response.data);
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
  Future<RegisterResponse> register(RegisterParams registerParams) async {
    try {
      final response = await _client.postRequest(
        ListApi.register,
        data: registerParams.toJson(),
      );
      final result = RegisterResponse.fromJson(response.data);
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
