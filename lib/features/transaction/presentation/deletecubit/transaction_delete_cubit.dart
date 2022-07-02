import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/del_transacton.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/usecase/get_detail_transaction.dart';
import 'transaction_delete_state.dart';

class TransactionDeleteCubit extends Cubit<TransactionDeleteState> {
  final DeleteTransaction deleteTransaction;
  TransactionDeleteCubit(this.deleteTransaction)
      : super(const TransactionDeleteState());

  Future<void> delTransactionID(TransactionIDParams params) async {
    emit(state.copyWith(status: TransDeleteStatus.loading));
    final data = await deleteTransaction.call(params);

    data.fold((left) {
      if (left is ServerFailure) {
        emit(state.copyWith(
            status: TransDeleteStatus.failure, message: left.message));
      }
    }, (right) {
      emit(state.copyWith(
        status: TransDeleteStatus.success,
        trans: right,
        message: right.meta?.message,
      ));
    });
  }
}
