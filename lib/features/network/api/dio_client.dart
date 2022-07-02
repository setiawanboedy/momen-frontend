import 'package:dio/dio.dart';

import '../../../../../di/di.dart';
import '../../auth/data/datasources/local/auth_pref_manager.dart';
import 'dio_interceptor.dart';

class DioClient {
  String baseUrl = "https://momenkuy.herokuapp.com";

  String? _auth;
  late Dio _dio;
  bool _isUnitTest = false;

  DioClient({bool isUnitTest = false}) {
    _isUnitTest = isUnitTest;

    try {
      _auth = sl<AuthPrefManager>().token;
    } catch (_) {}
    _dio = _createDio();
    if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());
  }
  // String? auth = sl<AuthPrefManager>().token;
  Dio _createDio() => Dio(
        BaseOptions(
            baseUrl: baseUrl,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              if (_auth != null) ...{'Authorization': "Bearer $_auth"}
            },
            receiveTimeout: 60000,
            connectTimeout: 60000,
            validateStatus: (int? status) {
              return status! > 0;
            }),
      );
  Dio get dio {
    if (_isUnitTest) {
      return _dio;
    } else {
      try {
        _auth = sl<AuthPrefManager>().token;
      } catch (_) {}
    }
    _auth = sl<AuthPrefManager>().token;
    _dio = _createDio();
    if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());
    return _dio;
  }

  Future<Response> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postRequest(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.post(url, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> deleteRequest(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.delete(url, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

    Future<Response> updateRequest(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.put(url, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
