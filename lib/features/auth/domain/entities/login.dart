import 'package:equatable/equatable.dart';

import '../../data/datasources/remote/model/login_response.dart';

class Login extends Equatable {
  final Data? data;
  final String? message;

  const Login(this.data, this.message);
  @override
  List<Object?> get props => [
        data,
        message,
      ];
}

class Profile extends Equatable {
  final String? name;
  final String? email;

  const Profile(this.name, this.email);
  @override
  List<Object?> get props => [
        name,
        email,
      ];
}