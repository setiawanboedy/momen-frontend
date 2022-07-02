import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/transaction_list.dart';
import '../../domain/usecase/get_transaction_list.dart';

part 'transaction_list_state.dart';

class TransactionListCubit extends Cubit<TransactionListState> {
  final GetTransactionList getTransactionList;
  TransactionListCubit(this.getTransactionList)
      : super(const TransactionListState());

  Future<void> fetchTransaction(NoParams params) async {
    emit(state.copyWith(status: TransStatus.loading));
    final data = await getTransactionList.call(params);

    data.fold((left) {
      if (left is ServerFailure) {
        emit(
            state.copyWith(status: TransStatus.failure, message: left.message));
      } else {
        emit(state.copyWith(status: TransStatus.empty));
      }
    }, (right) {
      Map<String, String> iconAdd = {
        "Pemasukan": "assets/icons/pemasukan.png",
        "Transportasi": "assets/icons/transportasi.png",
        "Makanan dan Minuman": "assets/icons/makan_minum.png",
        "Pulsa": "assets/icons/pulsa.png",
        "Kuota": "assets/icons/kuota.png",
        "Hutang": "assets/icons/hutang.png",
        "Belanja": "assets/icons/belanja.png",
        "Listrik": "assets/icons/listrik.png",
      };

      emit(state.copyWith(
        status: TransStatus.success,
        transList: right,
        iconCategory: iconAdd,
      ));
    });
  }
}
