import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/models/placemark_data.dart';


class ClientDestinationMapState extends Equatable {
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPositionDestination;
  final PlacemarkData? placemarkData;
  final LatLng? pickUpPLatLng;
  final LatLng? destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;
  final Map<MarkerId, Marker>? markers;

  const ClientDestinationMapState({
    this.position,
    this.controller,
    this.cameraPositionDestination = const CameraPosition(target: LatLng( 4.1247564,-73.6502597), zoom: 14.0),
    this.placemarkData,
    this.pickUpPLatLng,
    this.destinationLatLng,
    this.pickUpDescription = '',
    this.destinationDescription = '',
    this.markers = const <MarkerId, Marker>{},
  });

  ClientDestinationMapState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPositionDestination,
    PlacemarkData? placemarkData,
    LatLng? pickUpPLatLng,
    LatLng? destinationLatLng,
    String? pickUpDescription,
    String? destinationDescription,
    Map<MarkerId, Marker>? markers,

  }) {
    return ClientDestinationMapState(
      position: position ?? this.position,
      controller: controller ?? this.controller,
      cameraPositionDestination: cameraPositionDestination ?? this.cameraPositionDestination,
      placemarkData: placemarkData ?? this.placemarkData,
      pickUpPLatLng: pickUpPLatLng ?? this.pickUpPLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpDescription: pickUpDescription ?? this.pickUpDescription,
      destinationDescription: destinationDescription ?? this.destinationDescription,
      markers: markers ?? this.markers,
    );
  }


  @override
  List<Object?> get props => [
    position, 
    controller, 
    markers, 
    cameraPositionDestination, 
    placemarkData, 
    pickUpPLatLng, 
    destinationLatLng, 
    pickUpDescription, 
    destinationDescription, 
    ];
}