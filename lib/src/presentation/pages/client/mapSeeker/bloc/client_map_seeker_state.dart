import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/models/placemark_data.dart';


class ClientMapSeekerState extends Equatable {
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final PlacemarkData? placemarkData;
  final LatLng? pickUpPLatLng;
  final LatLng? destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;
  final bool isButtonEnabled;
  final bool isUpdateStatedestinatio;
  final Map<MarkerId, Marker> markers;
   final bool shouldExpandSheet;

  const ClientMapSeekerState({
    this.position,
    this.controller,
    this.cameraPosition = const CameraPosition(target: LatLng(4.1247564,-73.6502597 ), zoom: 14.0),
    this.placemarkData,
    this.pickUpPLatLng,
    this.destinationLatLng,
    this.pickUpDescription = '',
    this.destinationDescription = '',
    this.isButtonEnabled = false,
    this.isUpdateStatedestinatio = true,
    this.markers = const <MarkerId, Marker>{},
    this.shouldExpandSheet = false,
  });

  ClientMapSeekerState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    PlacemarkData? placemarkData,
    LatLng? pickUpPLatLng,
    LatLng? destinationLatLng,
    String? pickUpDescription,
    String? destinationDescription,
    bool? isButtonEnabled,
    bool? isUpdateStatedestinatio,
    Map<MarkerId, Marker>? markers,
    bool? shouldExpandSheet,
    

  }) {
    return ClientMapSeekerState(
      position: position ?? this.position,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      placemarkData: placemarkData ?? this.placemarkData,
      pickUpPLatLng: pickUpPLatLng ?? this.pickUpPLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpDescription: pickUpDescription ?? this.pickUpDescription,
      destinationDescription: destinationDescription ?? this.destinationDescription,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isUpdateStatedestinatio: isUpdateStatedestinatio ?? this.isUpdateStatedestinatio,
      markers: markers ?? this.markers,
      shouldExpandSheet: shouldExpandSheet ?? this.shouldExpandSheet,
    );
  }


  @override
  List<Object?> get props => [
    position, 
    controller, 
    markers, 
    cameraPosition, 
    placemarkData, 
    pickUpPLatLng, 
    destinationLatLng, 
    pickUpDescription, 
    destinationDescription, 
    isButtonEnabled,
    isUpdateStatedestinatio,
    shouldExpandSheet
    ];
}


// 4.7109886, -74.072092 bogota
// 4.1247564,-73.6502597 villavo