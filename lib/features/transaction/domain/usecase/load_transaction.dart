import 'package:dartz/dartz.dart';
import 'package:momen/core/usecase/usecase.dart';

import '../../../../core/failure/failure.dart';
import '../repository/trans_repository.dart';

class LoadFromDBTransaction extends UseCase<int, NoParams> {
  final TransRepository repository;

  LoadFromDBTransaction(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) {
    return repository.loadFromDBtoAPI(params);
  }
}

class LoadFromAPITransaction extends UseCase<int, NoParams> {
  final TransRepository repository;

  LoadFromAPITransaction(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) {
    return repository.loadFromAPItoDB(params);
  }
}