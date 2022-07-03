import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momen/features/home/splashscreen/load_from_api.dart';

import '../di/di.dart';
import '../features/auth/presentation/cubit/login_cubit.dart';
import '../features/auth/presentation/cubit/register_cubit.dart';
import '../features/auth/presentation/pages/auth/auth_screen.dart';
import '../features/home/detail/transaction_detail.dart';
import '../features/home/home_screen.dart';
import '../features/home/splashscreen/splash_screen.dart';
import '../features/transaction/presentation/deletecubit/transaction_delete_cubit.dart';
import '../features/transaction/presentation/getcubit/transaction_list_cubit.dart';
import '../features/transaction/presentation/getdetailcubit/transaction_detail_cubit.dart';
import '../features/transaction/presentation/pages/inoutcome.dart';
import '../features/transaction/presentation/postcubit/transaction_cubit.dart';
import '../features/transaction/presentation/updatecubit/transaction_update_cubit.dart';

class AppRoute {
  AppRoute._();

  static const String mainScreen = "main";
  static const String splashScreen = "splash";
  static const String inoutcome = "inoutcome";
  static const String loadFromApi = "loadfromapi";
  static const String detailTrans = "detail_transaction";

  ///auth
  static const String authScreen = "auth";

  //define
  static Map<String, WidgetBuilder> getRoutes({RouteSettings? settings}) => {
        mainScreen: (_) => MultiBlocProvider(providers: [
              BlocProvider(
                create: (_) => sl<LoginCubit>(),
              ),
              BlocProvider(
                create: (_) => sl<TransactionListCubit>(),
              ),
            ], child: const HomeScreen()),
        authScreen: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => sl<LoginCubit>(),
                ),
                BlocProvider(
                  create: (_) => sl<RegisterCubit>(),
                ),
              ],
              child: const AuthScreen(),
            ),
        inoutcome: (_) => MultiBlocProvider(providers: [
              BlocProvider(
                create: (_) => sl<TransactionCubit>(),
              ),
              BlocProvider(
                create: (_) => sl<TransactionDetailCubit>(),
              ),
              BlocProvider(
                create: (_) => sl<TransactionUpdateCubit>(),
              ),
            ], child: const InOutCome()),
        detailTrans: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => sl<TransactionDetailCubit>(),
                ),
                BlocProvider(
                  create: (_) => sl<TransactionDeleteCubit>(),
                ),
              ],
              child: const TransactionDetail(),
            ),
        splashScreen: (context) => const SplashScreen(),
        loadFromApi: (context) => BlocProvider(
              create: (context) => sl<TransactionListCubit>(),
              child: const LoadFromApi(),
            )
      };
}
