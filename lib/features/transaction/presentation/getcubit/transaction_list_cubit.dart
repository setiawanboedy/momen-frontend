import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momen/features/transaction/domain/usecase/load_transaction.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/transaction_list.dart';
import '../../domain/usecase/get_transaction_list.dart';

part 'transaction_list_state.dart';

class TransactionListCubit extends Cubit<TransactionListState> {
  final GetTransactionList getTransactionList;
  final LoadFromDBTransaction loadFromDBTransaction;
  final LoadFromAPITransaction loadFromAPITransaction;

  TransactionListCubit(
    this.getTransactionList,
    this.loadFromDBTransaction,
    this.loadFromAPITransaction,
  ) : super(const TransactionListState());

  Future<void> fetchTransaction(NoParams params) async {
    emit(state.copyWith(status: TransListStatus.loading));
    final data = await getTransactionList.call(params);

    data.fold((left) {
      if (left is ServerFailure) {
        emit(state.copyWith(
            status: TransListStatus.failure, message: left.message));
      } else {
        emit(state.copyWith(status: TransListStatus.empty));
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
      int totalAmount = 0;
      right.transList?.forEach(((amount) {
        totalAmount += amount.amount ?? 0;
      }));

      emit(state.copyWith(
        status: TransListStatus.success,
        totalAmount: totalAmount,
        transList: right,
        iconCategory: iconAdd,
      ));
    });
  }

  Future<void> loadFromDB(NoParams params) async {
    emit(state.copyWith(status: TransListStatus.loading));
    final data = await loadFromDBTransaction.call(params);

    data.fold((l) {
      CacheFailure(l.toString());
    }, (r) {
      emit(state.copyWith(status: TransListStatus.success));
    });
  }

  Future<void> loadFromAPI(NoParams params) async {
    emit(state.copyWith(status: TransListStatus.loading));
    final data = await loadFromAPITransaction.call(params);

    data.fold((l) {
      emit(state.copyWith(status: TransListStatus.failure));
    }, (r) {
      emit(state.copyWith(status: TransListStatus.success));
    });
  }
}
