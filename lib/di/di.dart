import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:momen/features/transaction/data/datasource/local/trans_local_datasource.dart';
import 'package:momen/features/transaction/domain/usecase/update_transaction.dart';
import 'package:momen/features/transaction/presentation/updatecubit/transaction_update_cubit.dart';
import '../features/transaction/domain/usecase/del_transacton.dart';
import '../features/transaction/domain/usecase/get_detail_transaction.dart';
import '../features/transaction/presentation/getdetailcubit/transaction_detail_cubit.dart';
import '../features/transaction/data/datasource/local/trans_pref_manager.dart';
import '../features/transaction/domain/usecase/get_transaction_list.dart';
import '../features/transaction/presentation/deletecubit/transaction_delete_cubit.dart';
import '../features/transaction/presentation/getcubit/transaction_list_cubit.dart';
import '../features/transaction/data/datasource/remote/trans_remote_datasource.dart';
import '../features/transaction/data/repository/trans_repository_impl.dart';
import '../features/transaction/domain/repository/trans_repository.dart';
import '../features/transaction/domain/usecase/post_transaction.dart';
import '../features/auth/data/datasources/local/auth_pref_manager.dart';
import '../features/auth/data/datasources/remote/auth_remote_datasources.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecase/post_login.dart';
import '../features/auth/domain/usecase/post_register.dart';
import '../features/auth/presentation/cubit/login_cubit.dart';
import '../features/auth/presentation/cubit/register_cubit.dart';
import '../features/home/settings/cubit/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/network/api/dio_client.dart';
import '../features/transaction/presentation/postcubit/transaction_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({bool isUnitTest = false}) async {
  if (isUnitTest) {
    WidgetsFlutterBinding.ensureInitialized();

    sl.reset();
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance().then((value) {
      initPrefManager(value);
    });

    sl.registerSingleton<DioClient>(DioClient(isUnitTest: true));
    datasources();
    repositories();
    useCase();
    cubit();
  } else {
    sl.registerSingleton<DioClient>(DioClient());
    datasources();
    repositories();
    useCase();
    cubit();
  }
}

void initPrefManager(SharedPreferences initPrefManager) {
  sl.registerLazySingleton<AuthPrefManager>(
      () => AuthPrefManager(initPrefManager));
  sl.registerLazySingleton<TransPrefManager>(
      () => TransPrefManager(initPrefManager));
}

void datasources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<TransRemoteDatasource>(
      () => TransRemoteDatasourceImpl(sl()));
   sl.registerLazySingleton<TransLocalDatasource>(
      () => TransLocalDatasourceImpl(sl()));    
}

void useCase() {
  sl.registerLazySingleton(() => PostLogin(sl()));
  sl.registerLazySingleton(() => PostRegister(sl()));
  sl.registerLazySingleton(() => PostTransaction(sl()));
  sl.registerLazySingleton(() => GetTransactionList(sl()));
  sl.registerLazySingleton(() => GetDetailTransaction(sl()));
  sl.registerLazySingleton(() => DeleteTransaction(sl()));
  sl.registerLazySingleton(() => UpdateTransaction(sl()));
}

void cubit() {
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => SettingsCubit());
  sl.registerFactory(() => TransactionCubit(sl()));
  sl.registerFactory(() => TransactionListCubit(sl()));
  sl.registerFactory(() => TransactionDetailCubit(sl()));
  sl.registerFactory(() => TransactionDeleteCubit(sl()));
  sl.registerFactory(() => TransactionUpdateCubit(sl()));
}

void repositories() {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<TransRepository>(() => TransRepositoryImpl(sl(), sl()));
}
