// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

import 'package:hey_taxi_app/src/domain/models/user.dart';

AuthResponseModel authResponseFromJson(String str) => AuthResponseModel.fromJson(json.decode(str));

String authResponseToJson(AuthResponseModel data) => json.encode(data.toJson());

class AuthResponseModel {
    User user;
    String token;

    AuthResponseModel({
        required this.user,
        required this.token,
    });

    factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
        user: User.fromJson(json["user"]),
        token: json["token"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}
