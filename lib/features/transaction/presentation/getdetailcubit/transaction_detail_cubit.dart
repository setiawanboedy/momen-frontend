import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/usecase/get_detail_transaction.dart';
import 'transaction_detail_state.dart';

class TransactionDetailCubit extends Cubit<TransactionDetailState> {
  final GetDetailTransaction detailTransaction;
  TransactionDetailCubit(this.detailTransaction)
      : super(const TransactionDetailState());

  Future<void> detailTransactionID(TransactionIDParams params) async {
    emit(state.copyWith(status: TransDetailStatus.loading));
    final data = await detailTransaction.call(params);

    data.fold((left) {
      if (left is ServerFailure) {
        emit(state.copyWith(
            status: TransDetailStatus.failure, message: left.message));
      }
    }, (right) {
      emit(state.copyWith(
        status: TransDetailStatus.success,
        trans: right,
        message: right.meta?.message,
      ));
    });
  }
}
