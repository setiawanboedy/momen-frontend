
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/login.dart';
import '../../domain/entities/register.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecase/post_login.dart';
import '../../domain/usecase/post_register.dart';
import '../datasources/remote/auth_remote_datasources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, Login>> login(LoginParams loginParams) async {
    try {
      final response = await authRemoteDataSource.login(loginParams);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Register>> register(
      RegisterParams registerParams) async {
    try {
      final response = await authRemoteDataSource.register(registerParams);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
