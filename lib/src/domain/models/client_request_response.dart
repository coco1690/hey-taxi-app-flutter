// To parse this JSON data, do
//
//     final clientRequestResponsde = clientRequestResponsdeFromJson(jsonString);

import 'dart:convert';

ClientRequestResponse clientRequestResponsdeFromJson(String str) => ClientRequestResponse.fromJson(json.decode(str));

String clientRequestResponsdeToJson(ClientRequestResponse data) => json.encode(data.toJson());

class ClientRequestResponse {
    int id;
    int idClient;
    dynamic fareOffered;
    dynamic detailsLocation;
    String pickupDescription;
    String destinationDescription;
    String status;
    String metodPay;
    DateTime updatedAt;
    Position pickupPosition;
    Position? destinationPosition;
    double? distanceKm;
    String timeDifference;
    Client client;
    GoogleDistanceMatrix googleDistanceMatrix;

    ClientRequestResponse({
        required this.id,
        required this.idClient,
        required this.fareOffered,
        required this.detailsLocation,
        required this.pickupDescription,
        required this.destinationDescription,
        required this.status,
        required this.metodPay,
        required this.updatedAt,
        required this.pickupPosition,
        required this.destinationPosition,
        this.distanceKm,
        required this.timeDifference,
        required this.client,
        required this.googleDistanceMatrix,
    });

    static List<ClientRequestResponse> fromJsonList(List<dynamic> jsonList) {
        List<ClientRequestResponse> toList = [];
        for (var json in jsonList) { 
        ClientRequestResponse clientRequestResponse = ClientRequestResponse.fromJson(json);
        toList.add(clientRequestResponse);
      }
        return toList;

    }

    factory ClientRequestResponse.fromJson(Map<String, dynamic> json) => ClientRequestResponse(
        id: json["id"],
        idClient: json["id_client"],
        fareOffered: json["fare_offered"],
        detailsLocation: json["details_location"],
        pickupDescription: json["pickup_description"],
        destinationDescription: json["destination_description"],
        status: json["status"],
        metodPay: json["metod_pay"],
        updatedAt: DateTime.parse(json["updated_at"]),
        pickupPosition: Position.fromJson(json["pickup_position"]),
        destinationPosition: Position.fromJson(json["destination_position"]),
        distanceKm: json["distance_km"]?.toDouble(),
        timeDifference: json["time_difference"],
        client: Client.fromJson(json["client"]),
        googleDistanceMatrix: GoogleDistanceMatrix.fromJson(json["google_distance_matrix"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "fare_offered": fareOffered,
        "details_location": detailsLocation,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
        "status": status,
        "metod_pay": metodPay,
        "updated_at": updatedAt.toIso8601String(),
        "pickup_position": pickupPosition.toJson(),
        "destination_position": destinationPosition?.toJson(),
        "distance_km": distanceKm,
        "time_difference": timeDifference,
        "client": client.toJson(),
        "google_distance_matrix": googleDistanceMatrix.toJson(),
    };
}

class Client {
    String name;
    String phone;
    String? image;

    Client({
        required this.name,
        required this.phone,
        this.image,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        name: json["name"],
        phone: json["phone"],
        image: json["image"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "image": image,
    };
}

class Position {
    double x;
    double y;

    Position({
        required this.x,
        required this.y,
    });

    factory Position.fromJson(Map<String, dynamic> json) => Position(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
    };
}

class GoogleDistanceMatrix {
    Distance distance;
    Distance duration;
    String status;

    GoogleDistanceMatrix({
        required this.distance,
        required this.duration,
        required this.status,
    });

    factory GoogleDistanceMatrix.fromJson(Map<String, dynamic> json) => GoogleDistanceMatrix(
        distance: Distance.fromJson(json["distance"]),
        duration: Distance.fromJson(json["duration"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "distance": distance.toJson(),
        "duration": duration.toJson(),
        "status": status,
    };
}

class Distance {
    String text;
    int value;

    Distance({
        required this.text,
        required this.value,
    });

    factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: json["text"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
    };
}
