import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/palette.dart';
import '../../core/usecase/usecase.dart';
import '../../resources/dimens.dart';
import '../../utils/currency_format.dart';
import '../../widgets/empty.dart';
import '../transaction/presentation/getcubit/transaction_list_cubit.dart';

class CardMoney extends StatelessWidget {
  const CardMoney({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimens.space16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1, 1),
              blurRadius: 10,
            )
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Palette.orangeLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimens.space16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/icons/wallet.png'),
                          BlocBuilder<TransactionListCubit,
                              TransactionListState>(
                            builder: (context, state) {
                              switch (state.status) {
                                case TransListStatus.loading:
                                  context
                                      .read<TransactionListCubit>()
                                      .getTransactionList(NoParams());
                                  return _totalMoney(state);
                                case TransListStatus.success:
                                  return _totalMoney(state);
                                case TransListStatus.empty:
                                  return _totalMoney(state);

                                case TransListStatus.failure:
                                  return const Empty();
                              }
                            },
                          ),
                          SizedBox(
                            width: size.height * 0.045,
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Pemasukan",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Rp 10.000.000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Pengeluaran",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Rp 5.000.000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _totalMoney(TransactionListState state) {
  return Text(
    "Rp ${CurrencyFormat.convertToIdr(state.transList?.totalAmount ?? state.totalAmount, 0)}",
    style: const TextStyle(
      color: Colors.white,
      fontSize: 24,
    ),
  );
}
