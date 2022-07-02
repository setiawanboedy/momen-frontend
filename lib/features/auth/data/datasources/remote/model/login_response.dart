import 'package:equatable/equatable.dart';

import '../../../../domain/entities/login.dart';

class LoginResponse extends Equatable {
  const LoginResponse({
    this.meta,
    this.data,
  });

  final Meta? meta;
  final Data? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        meta: Meta?.fromJson(json["meta"] ?? {}),
        data: Data?.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [
        meta,
        data,
      ];

  Login toEntity() => Login(data, meta?.message);
}

class Data extends Equatable {
  const Data({
    this.id,
    this.name,
    this.email,
    this.token,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "token": token,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        token,
      ];
}

class Meta extends Equatable {
  const Meta({
    this.message,
    this.code,
    this.status,
  });

  final String? message;
  final int? code;
  final String? status;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "status": status,
      };

  @override
  List<Object?> get props => [
        message,
        code,
        status,
      ];
}
