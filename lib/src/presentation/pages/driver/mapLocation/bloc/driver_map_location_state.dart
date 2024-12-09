import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart';



class DriverMapLocationState extends Equatable {
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final bool isUpdateStatedestinatio;
  final Map<MarkerId, Marker> markers;
  final Socket? socket;

  const DriverMapLocationState({
    this.controller,
    this.position,
    this.cameraPosition = const CameraPosition(target: LatLng(4.1247564,-73.6502597 ), zoom: 14.0),
    this.isUpdateStatedestinatio = true,
    this.markers = const <MarkerId, Marker>{},
    this.socket,
    
  });

  DriverMapLocationState copyWith({
    Completer<GoogleMapController>? controller,
    Position? position,
    CameraPosition? cameraPosition,
    bool? isUpdateStatedestinatio,
    Map<MarkerId, Marker>? markers, 
    Socket? socket,

  }) {
    
    //VALIDACION PARA MANTENER SU ESTADO
    return DriverMapLocationState(
      controller: controller ?? this.controller,
      position: position ?? this.position,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      isUpdateStatedestinatio: isUpdateStatedestinatio ?? this.isUpdateStatedestinatio,
      markers: markers ?? this.markers,
      socket: socket ?? this.socket,
    );
  }


  @override
  List<Object?> get props => [
    controller, 
    position, 
    markers, 
    cameraPosition, 
    isUpdateStatedestinatio,
    socket
    ];
}


// 4.7109886, -74.072092 bogota
// 4.1247564,-73.6502597 villavo