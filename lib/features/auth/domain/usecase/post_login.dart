import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/login.dart';
import '../repositories/auth_repository.dart';

class PostLogin extends UseCase<Login, LoginParams> {
  final AuthRepository repository;

  PostLogin(this.repository);

  @override
  Future<Either<Failure, Login>> call(LoginParams params) {
    return repository.login(params);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    this.email = '',
    this.password = '',
  });
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
