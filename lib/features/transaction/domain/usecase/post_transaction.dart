import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/trans_repository.dart';

class PostTransaction extends UseCase<int?, TransactionParams> {
  final TransRepository repository;

  PostTransaction(this.repository);
  @override
  Future<Either<Failure, int>> call(TransactionParams params) {
    return repository.createRemoteTrans(params);
  }
}


class TransactionParams extends Equatable {
  final int? transID;
  final int? userID;
  final String? description;
  final String? category;
  final int? amount;

  const TransactionParams({
    this.transID,
    this.userID,
    this.description,
    this.category,
    this.amount,
  });

  TransactionParams copyWith({
    int? transID,
    int? userID,
  }) {
    return TransactionParams(
      transID: transID ?? this.transID,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': transID,
        'user_id': userID,
        'description': description,
        'category': category,
        'amount': amount,
      };

  Map<String, dynamic> toJsonApi() => {
        'id': transID,
        'description': description,
        'category': category,
        'amount': amount,
      };

  @override
  List<Object?> get props => [
        transID,
        userID,
        description,
        category,
        amount,
      ];
}
