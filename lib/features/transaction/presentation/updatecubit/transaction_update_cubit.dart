import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/update_transaction.dart';

import '../../../../core/failure/failure.dart';
import 'transaction_update_state.dart';

class TransactionUpdateCubit extends Cubit<TransactionUpdateState> {
  final UpdateTransaction updateTransaction;
  TransactionUpdateCubit(this.updateTransaction)
      : super(const TransactionUpdateState());

  Future<void> updateTransactionID(TransactionUpdateParams params) async {
    emit(state.copyWith(status: TransUpdateStatus.loading));
    final data = await updateTransaction.call(params);

    data.fold((left) {
      if (left is ServerFailure) {
        emit(state.copyWith(
            status: TransUpdateStatus.failure, message: left.message));
      }
    }, (right) {
      emit(state.copyWith(
        status: TransUpdateStatus.success,
        trans: right,
        message: right.meta?.message,
      ));
    });
  }
}
