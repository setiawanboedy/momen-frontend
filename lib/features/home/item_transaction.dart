import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../routes/app_route.dart';
import '../../utils/ext/context.dart';
import '../../utils/currency_format.dart';
import '../transaction/presentation/getcubit/transaction_list_cubit.dart';
import '../../resources/dimens.dart';
import '../../widgets/empty.dart';

import '../transaction/data/datasource/remote/model/transaction_response.dart';

class ItemTransaction extends StatelessWidget {
  final Data transaction;
  const ItemTransaction({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => context.goTo(AppRoute.detailTrans, args: transaction.id)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                offset: Offset(1, 0.5),
                blurRadius: 10,
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.all(-6),
                leading:
                    BlocBuilder<TransactionListCubit, TransactionListState>(
                  builder: (context, state) {
                    if (state.status == TransStatus.loading) {
                      return const CircularProgressIndicator();
                    } else if (state.status == TransStatus.success) {
                      return Image.asset(
                        "${state.iconCategory![transaction.category]}",
                        scale: 0.7,
                      );
                    }
                    return const Empty();
                  },
                ),
                subtitle: Text(
                  "${transaction.description}",
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                title: Text(
                  "${transaction.category}",
                  style: TextStyle(fontSize: Dimens.space16),
                ),
                trailing: Text(
                  "Rp ${CurrencyFormat.convertToIdr(transaction.amount, 0)}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
