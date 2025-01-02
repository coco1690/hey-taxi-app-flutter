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
  final int? idDriver;

  const DriverMapLocationState({
    this.position,
    this.controller,
    this.cameraPosition = const CameraPosition(target: LatLng(4.1247564,-73.6502597 ), zoom: 14.0),
    this.isUpdateStatedestinatio = true,
    this.markers = const <MarkerId, Marker>{},
    this.idDriver,
    
  });

  DriverMapLocationState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    bool? isUpdateStatedestinatio,
    Map<MarkerId, Marker>? markers, 
    int? idDriver,

  }) {
    
    //VALIDACION PARA MANTENER SU ESTADO
    return DriverMapLocationState(
      position: position ?? this.position,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      isUpdateStatedestinatio: isUpdateStatedestinatio ?? this.isUpdateStatedestinatio,
      markers: markers ?? this.markers,
      idDriver: idDriver ?? this.idDriver,
    );
  }


  @override
  List<Object?> get props => [
    position, 
    controller, 
    markers, 
    cameraPosition, 
    isUpdateStatedestinatio,
    idDriver,

    ];
}


// 4.7109886, -74.072092 bogota
// 4.1247564,-73.6502597 villavo