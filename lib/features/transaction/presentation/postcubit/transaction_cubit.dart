import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/failure/failure.dart';
import '../../../../utils/common.dart';
import '../../domain/usecase/post_transaction.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final PostTransaction postTransaction;
  TransactionCubit(this.postTransaction) : super(const TransactionState());

  Future<void> createTransaction(TransactionParams params) async {
    emit(state.copyWith(status: TransStatus.loading));
    final data = await postTransaction.call(params);

    data.fold((left) {
      if (left is ServerFailure) {
        emit(
            state.copyWith(status: TransStatus.failure, message: left.message));
      }
    }, (right) {
      emit(state.copyWith(
        status: TransStatus.success,
        transID: right,
        message: "Success",
      ));
    });
  }
}
