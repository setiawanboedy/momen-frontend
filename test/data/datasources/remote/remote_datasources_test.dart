import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:momen/core/error/exceptions.dart';

import 'package:momen/di/di.dart';
import 'package:momen/features/auth/data/datasources/remote/auth_remote_datasources.dart';
import 'package:momen/features/auth/data/datasources/remote/model/login_response.dart';
import 'package:momen/features/auth/domain/usecase/post_login.dart';
import 'package:momen/features/network/api/dio_client.dart';
import 'package:momen/features/network/api/list_api.dart';

import '../../../helpers/json_reader.dart';
import '../../../helpers/paths.dart';

void main() {
  late DioAdapter dioAdapter;
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() async {
    await serviceLocator(isUnitTest: true);
    dioAdapter = DioAdapter(dio: sl<DioClient>().dio);
    dataSource = AuthRemoteDataSourceImpl(sl<DioClient>());
  });

  group('login', () {
    final loginParams =
        LoginParams(email: 'sinaga@gmail.com', password: 'rendi');
    final loginModel =
        LoginResponse.fromJson(json.decode(jsonReader(successLoginPath)));

    test('should return success model', () async {
      ///arrange
      dioAdapter.onPost(
        ListApi.login,
        (server) => server.reply(
          200,
          json.decode(jsonReader(successLoginPath)),
        ),
        data: loginParams.toJson(),
      );

      /// act
      final result = await dataSource.login(loginParams);

      /// assert
      expect(loginModel, equals(result));
    });

    test(
      'should return login unsuccessful model when response code is 400',
      () async {
        /// arrange
        dioAdapter.onPost(
          ListApi.login,
          (server) => server.reply(
            400,
            json.decode(jsonReader(unsuccessLoginPath)),
          ),
          data: loginParams.toJson(),
        );

        /// act
        final result = dataSource.login(loginParams);

        /// assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
