import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momen/di/di.dart';
import 'package:momen/features/network/db/trans_database.dart';
import '../../core/usecase/usecase.dart';
import '../transaction/presentation/getcubit/transaction_list_cubit.dart';
import '../../widgets/empty.dart';
import '../../widgets/loading.dart';
import '../../routes/app_route.dart';
import '../../utils/ext/context.dart';
import '../../utils/ext/string.dart';
import '../../widgets/parent.dart';
import '../../resources/dimens.dart';
import '../../resources/palette.dart';

import '../../widgets/welcome.dart';
import '../auth/presentation/cubit/login_cubit.dart';
import 'card_money.dart';
import 'item_transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<TransactionListCubit>().fetchTransaction(NoParams());
    context.read<TransactionListCubit>().loadFromDB(NoParams());
    context.read<LoginCubit>().profile();
    super.initState();
  }

  @override
  void dispose() {
    sl<TransDatabase>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Parent(
      floatingButton: FloatingActionButton(
        onPressed: () => context.goTo(AppRoute.inoutcome),
        backgroundColor: Palette.orangeLight,
        child: const Icon(Icons.add),
      ),
      child: Stack(
        children: [
          Stack(
            children: [
              FractionallySizedBox(
                heightFactor: 0.35,
                child: Container(
                  color: Palette.green,
                ),
              ),
              Container(
                height: 70,
                width: 70,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                right: 0,
                bottom: -5,
                child: Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: -5,
                child: Container(
                  height: 140,
                  width: 140,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      switch (state.status) {
                        case LoginStatus.loading:
                          context.show();
                          break;
                        case LoginStatus.success:
                          context.dismiss();
                          state.message.toString().toToastSuccess();
                          context.goToReplace(AppRoute.authScreen);
                          break;
                        case LoginStatus.failure:
                          context.dismiss();
                          state.message.toString().toToastError();
                          break;
                      }
                    },
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (() {
                            context.read<LoginCubit>().logout();
                          }),
                          child: Image.asset('assets/icons/coin.png'),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: EdgeInsets.all(Dimens.space16),
                alignment: Alignment.topLeft,
                height: (size.height / 4) - size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            if (state.status == LoginStatus.loading) {
                              return welcome();
                            } else if (state.status == LoginStatus.success) {
                              return welcome(name: state.profile?.name);
                            } else {
                              return welcome();
                            }
                          },
                        ),
                        const Text(
                          "Selamat datang di aplikasi Momen",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CardMoney(size: size),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Text(
                  "Transaksi Terbaru",
                  style: TextStyle(
                    color: Palette.greenText,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<TransactionListCubit, TransactionListState>(
                        builder: (_, state) {
                          switch (state.status) {
                            case TransListStatus.loading:
                              return const Loading();

                            case TransListStatus.success:
                              return ListView.separated(
                                reverse: true,
                                padding: EdgeInsets.all(Dimens.space16),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ItemTransaction(
                                      transaction:
                                          state.transList!.transList![index]);
                                },
                                separatorBuilder: (context, _) {
                                  return const SizedBox(
                                    height: 16,
                                  );
                                },
                                itemCount:
                                    state.transList?.transList?.length ?? 0,
                              );

                            case TransListStatus.empty:
                              return const Center(
                                  child: Text("Tidak ada transaksi"));
                            case TransListStatus.failure:
                              return const Center(
                                child: Empty(
                                  errorMessage: "Error",
                                ),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
