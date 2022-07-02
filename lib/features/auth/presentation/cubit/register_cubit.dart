import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entities/register.dart';
import '../../domain/usecase/post_register.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final PostRegister postRegister;

  RegisterCubit(this.postRegister) : super(const RegisterState());

  Future<void> register(RegisterParams params) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    final data = await postRegister.call(params);
    data.fold(
      (left) {
        if (left is ServerFailure) {
          emit(
            state.copyWith(
                status: RegisterStatus.failure, message: left.message),
          );
        }
      },
      (right) => emit(
        state.copyWith(
          status: RegisterStatus.success,
          register: right,
        ),
      ),
    );
  }
}
