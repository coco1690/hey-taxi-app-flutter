// To parse this JSON data, do
//
//     final driverTripRequest = driverTripRequestFromJson(jsonString);

import 'dart:convert';

import 'package:hey_taxi_app/src/domain/models/user.dart';

DriverTripRequest driverTripRequestFromJson(String str) => DriverTripRequest.fromJson(json.decode(str));

String driverTripRequestToJson(DriverTripRequest data) => json.encode(data.toJson());

class DriverTripRequest {
    int? id;
    int idDriver;
    int idClientRequest;
    int? fareOffered;
    double time;
    double distance;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? driver;

    DriverTripRequest({
        this.id,
        required this.idDriver,
        required this.idClientRequest,
        this.fareOffered,
        required this.time,
        required this.distance,
        this.createdAt,
        this.updatedAt,
        this.driver,
    });

    factory DriverTripRequest.fromJson(Map<String, dynamic> json) => DriverTripRequest(
        id: json["id"],
        idDriver: json["id_driver"],
        idClientRequest: json["id_client_request"],
        fareOffered: json["fare_offered"],
        time: json["time"] is int ? json["time"].toDouble() : json["time"],
        distance: json["distance"] is int ? json["distance"].toDouble() : json["distance"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        driver: User.fromJson(json["driver"]),
    );

    Map<String, dynamic> toJson() => {
        "id_driver": idDriver,
        "id_client_request": idClientRequest,
        "fare_offered": fareOffered,
        "time": time,
        "distance": distance,
    };
}


