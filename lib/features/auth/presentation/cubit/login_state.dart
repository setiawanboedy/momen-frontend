part of 'login_cubit.dart';

enum LoginStatus {
  loading,
  success,
  failure;

  bool get isLoading => this == LoginStatus.loading;

  bool get isSuccess => this == LoginStatus.success;

  bool get isFailure => this == LoginStatus.failure;
}

class LoginState extends Equatable {
  final LoginStatus status;
  final Login? login;
  final Profile? profile;
  final String? message;

  const LoginState({
    this.status = LoginStatus.loading,
    this.login,
    this.profile,
    this.message,
  });

  LoginState copyWith({
    LoginStatus? status,
    Login? login,
    Profile? profile,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      login: login ?? this.login,
      profile: profile ?? this.profile,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        login,
        profile,
        message,
      ];
}
