import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entities/login.dart';
import '../entities/register.dart';
import '../usecase/post_login.dart';
import '../usecase/post_register.dart';

abstract class AuthRepository {
  Future<Either<Failure, Login>> login(LoginParams loginParams);
  Future<Either<Failure, Register>> register(RegisterParams registerParams);
}
