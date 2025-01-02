// To parse this JSON data, do
//
//     final timeAndDistanceValues = timeAndDistanceValuesFromJson(jsonString);

import 'dart:convert';

TimeAndDistanceValues timeAndDistanceValuesFromJson(String str) => TimeAndDistanceValues.fromJson(json.decode(str));

String timeAndDistanceValuesToJson(TimeAndDistanceValues data) => json.encode(data.toJson());

class TimeAndDistanceValues {
    double recommendedValue;
    String destinationAddresses;
    String originAddresses;
    Distance distance;
    Durations duration;

    TimeAndDistanceValues({
        required this.recommendedValue,
        required this.destinationAddresses,
        required this.originAddresses,
        required this.distance,
        required this.duration,
    });

    factory TimeAndDistanceValues.fromJson(Map<String, dynamic> json) => TimeAndDistanceValues(
        recommendedValue: json["recommended_value"]?.toDouble(),
        destinationAddresses: json["destination_addresses"],
        originAddresses: json["origin_addresses"],
        distance: Distance.fromJson(json["distance"]),
        duration: Durations.fromJson(json["duration"]),
    );

    Map<String, dynamic> toJson() => {
        "recommended_value": recommendedValue,
        "destination_addresses": destinationAddresses,
        "origin_addresses": originAddresses,
        "distance": distance.toJson(),
        "duration": duration.toJson(),
    };
}

class Distance {
    String text;
    double value;

    Distance({
        required this.text,
        required this.value,
    });

    factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: json["text"],
        value: json["value"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
    };
}

class Durations {
    String text;
    double value;

    Durations({
        required this.text,
        required this.value,
    });

    factory Durations.fromJson(Map<String, dynamic> json) => Durations(
        text: json["text"],
        value: json["value"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
    };
}
