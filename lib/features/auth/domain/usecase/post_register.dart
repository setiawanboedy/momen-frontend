import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/register.dart';
import '../repositories/auth_repository.dart';

class PostRegister extends UseCase<Register, RegisterParams> {
  final AuthRepository repository;

  PostRegister(this.repository);
  @override
  Future<Either<Failure, Register>> call(RegisterParams params) {
    return repository.register(params);
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    this.name = '',
    this.email = '',
    this.password = '',
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
}
