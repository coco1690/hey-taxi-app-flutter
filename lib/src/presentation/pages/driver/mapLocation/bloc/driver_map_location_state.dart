import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class DriverMapLocationState extends Equatable {
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final bool isUpdateStatedestinatio;
  final Map<MarkerId, Marker> markers;

  const DriverMapLocationState({
    this.controller,
    this.position,
    this.cameraPosition = const CameraPosition(target: LatLng(4.1247564,-73.6502597 ), zoom: 14.0),
    this.isUpdateStatedestinatio = true,
    this.markers = const <MarkerId, Marker>{},
  });

  DriverMapLocationState copyWith({
    Completer<GoogleMapController>? controller,
    Position? position,
    CameraPosition? cameraPosition,
    bool? isUpdateStatedestinatio,
    Map<MarkerId, Marker>? markers,

  }) {
    return DriverMapLocationState(
      controller: controller ?? this.controller,
      position: position ?? this.position,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      isUpdateStatedestinatio: isUpdateStatedestinatio ?? this.isUpdateStatedestinatio,
      markers: markers ?? this.markers,
    );
  }


  @override
  List<Object?> get props => [
    controller, 
    position, 
    markers, 
    cameraPosition, 
    isUpdateStatedestinatio
    ];
}


// 4.7109886, -74.072092 bogota
// 4.1247564,-73.6502597 villavo