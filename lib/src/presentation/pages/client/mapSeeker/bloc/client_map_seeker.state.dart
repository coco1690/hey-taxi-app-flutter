import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/models/placemark_data.dart';


class ClientMapSeekerState extends Equatable {
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final CameraPosition cameraPositionDestination;
  final PlacemarkData? placemarkData;
  final LatLng? pickUpPLatLng;
  final LatLng? destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;
  
  final Map<MarkerId, Marker>? markers;

  const ClientMapSeekerState({
    this.position,
    this.controller,
    this.cameraPosition = const CameraPosition(target: LatLng( 4.1247564,-73.6502597), zoom: 14.0),
    this.cameraPositionDestination = const CameraPosition(target: LatLng( 4.1247564,-73.6502597), zoom: 14.0),
    this.placemarkData,
    this.pickUpPLatLng,
    this.destinationLatLng,
    this.pickUpDescription = '',
    this.destinationDescription = '',
    this.markers = const <MarkerId, Marker>{},
  });

  ClientMapSeekerState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    CameraPosition? cameraPositionDestination,
    PlacemarkData? placemarkData,
    LatLng? pickUpPLatLng,
    LatLng? destinationLatLng,
    String? pickUpDescription,
    String? destinationDescription,
    Map<MarkerId, Marker>? markers,

  }) {
    return ClientMapSeekerState(
      position: position ?? this.position,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
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
  List<Object?> get props => [position, controller, markers, cameraPosition, cameraPositionDestination, placemarkData, pickUpPLatLng, destinationLatLng, pickUpDescription, destinationDescription];
}