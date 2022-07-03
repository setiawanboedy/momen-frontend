import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/currency_format.dart';
import '../../transaction/presentation/deletecubit/transaction_delete_cubit.dart';
import '../../transaction/presentation/getdetailcubit/transaction_detail_cubit.dart';
import '../../../routes/app_route.dart';
import '../../../utils/ext/context.dart';

import '../../../../widgets/parent.dart';
import '../../../../resources/dimens.dart';
import '../../../../resources/palette.dart';
import '../../transaction/domain/usecase/get_detail_transaction.dart';
import '../../transaction/presentation/getdetailcubit/transaction_detail_state.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int? transID = context.argsData() as int?;
    context
        .read<TransactionDetailCubit>()
        .detailTransactionID(TransactionIDParams(transID: transID));

    return BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
      builder: (context, state) {
        return _transactionDetail(context, state);
      },
    );
  }
}

Widget _transactionDetail(BuildContext context, TransactionDetailState state) {
  return Parent(
    backgroundColor: Palette.bgColor,
    appBar: AppBar(
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {
          context.goToReplace(AppRoute.mainScreen);
        },
        child: const Icon(Icons.arrow_back),
      ),
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(Dimens.space16),
          onTap: () {
            context.goTo(AppRoute.inoutcome, args: state.trans);
          },
          child: Container(
            padding: EdgeInsets.all(Dimens.space12),
            child: const Icon(Icons.edit),
          ),
        ),
        InkWell(
          onTap: () {
            context.read<TransactionDeleteCubit>().delTransactionID(
                  TransactionIDParams(transID: state.trans?.data?.id),
                );
            context.goTo(AppRoute.mainScreen);
          },
          borderRadius: BorderRadius.circular(Dimens.space16),
          child: Container(
            padding: EdgeInsets.all(Dimens.space12),
            child: const Icon(Icons.delete),
          ),
        ),
      ],
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: Palette.bgColor,
    ),
    child: SingleChildScrollView(
      padding: EdgeInsets.all(Dimens.space16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),

          const Text(
            "Kategori",
            style: TextStyle(
              color: Palette.greenText,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            enabled: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: state.trans?.data?.category ?? "Kategori",
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // const Text(
          //   "Tanggal",
          //   style: TextStyle(
          //     color: Palette.greenText,
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // const TextField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     labelText: "Hari/Bulan/Tahun",
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Jumlah",
            style: TextStyle(
              color: Palette.greenText,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            enabled: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: CurrencyFormat.convertToIdr(
                  state.trans?.data?.amount?.abs(), 0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Catatan",
            style: TextStyle(
              color: Palette.greenText,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: TextField(
              enabled: false,
              maxLines: 5,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: state.trans?.data?.description ?? "Keterangan",
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}
