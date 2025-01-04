// To parse this JSON data, do
//
//     final clientRequest = clientRequestFromJson(jsonString);

import 'dart:convert';

ClientRequest clientRequestFromJson(String str) => ClientRequest.fromJson(json.decode(str));

String clientRequestToJson(ClientRequest data) => json.encode(data.toJson());

class ClientRequest {
    // int? id;
    int idClient;
    int? fareOffered; // ofertar tarifa
    String? detailsLocation; // detalles de la ubicacion como barrio, localidad, etc
    String pickupDescription;
    String? destinationDescription;
    double pickupLat;
    double pickupLng;
    double? destinationLat;
    double? destinationLng;

    ClientRequest({
        // this.id,
        required this.idClient,
        this.fareOffered,
        this.detailsLocation,
        required this.pickupDescription,
        this.destinationDescription,
        required this.pickupLat,
        required this.pickupLng,
        this.destinationLat,
        this.destinationLng,
    });

    factory ClientRequest.fromJson(Map<String, dynamic> json) => ClientRequest(
        // id: json["id"],
        idClient: json["id_client"],
        fareOffered: json["fare_offered"],
        detailsLocation: json["details_location"],
        pickupDescription: json["pickup_description"],
        destinationDescription: json["destination_description"],
        pickupLat: json["pickup_lat"]?.toDouble(),
        pickupLng: json["pickup_lng"]?.toDouble(),
        destinationLat: json["destination_lat"]?.toDouble(),
        destinationLng: json["destination_lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        // "id": id,
        "id_client": idClient,
        "fare_offered": fareOffered,
        "details_location": detailsLocation,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
        "pickup_lat": pickupLat,
        "pickup_lng": pickupLng,
        "destination_lat": destinationLat,
        "destination_lng": destinationLng,
    };
}
