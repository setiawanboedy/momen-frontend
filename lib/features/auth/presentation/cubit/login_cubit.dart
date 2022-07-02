import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../utils/common.dart';

import '../../../../core/failure/failure.dart';
import '../../../../di/di.dart';
import '../../data/datasources/local/auth_pref_manager.dart';
import '../../domain/entities/login.dart';
import '../../domain/usecase/post_login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final PostLogin postLogin;
  LoginCubit(this.postLogin) : super(const LoginState());

  Future<void> login(LoginParams params) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final data = await postLogin.call(params);

    data.fold((left) {
      if (left is ServerFailure) {
        emit(
            state.copyWith(status: LoginStatus.failure, message: left.message));
      }
    }, (right) {
      sl<AuthPrefManager>().isLogin = true;
      sl<AuthPrefManager>().userID = right.data?.id;
      sl<AuthPrefManager>().token = right.data?.token;
      sl<AuthPrefManager>().name = right.data?.name;
      sl<AuthPrefManager>().email = right.data?.email;
      emit(state.copyWith(
        status: LoginStatus.success,
        login: right,
      ));
    });
  }

  void logout() {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      sl<AuthPrefManager>().token = '';
      sl<AuthPrefManager>().isLogin = false;
      sl<AuthPrefManager>().userID = 0;
      sl<AuthPrefManager>().name = '';
      sl<AuthPrefManager>().email = '';

      emit(state.copyWith(
        status: LoginStatus.success,
        message: "Logout Success",
      ));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void profile() {
    final name = sl<AuthPrefManager>().name;
    final email = sl<AuthPrefManager>().email;
    emit(state.copyWith(
      status: LoginStatus.success,
      profile: Profile(name, email),
    ));
  }
}
