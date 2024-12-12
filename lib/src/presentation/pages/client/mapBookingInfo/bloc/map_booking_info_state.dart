import 'dart:async';
 
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';



class ClientMapBookingInfoState extends Equatable {
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPositionBooking;
  final LatLng? pickUpPLatLng;
  final LatLng? destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines ;
  final bool isBottomSheetExpanded;
  final Resource? responseTimeAndDistance;

  const ClientMapBookingInfoState({
    this.position,
    this.controller,
    this.cameraPositionBooking = const CameraPosition(target: LatLng(4.1247564,-73.6502597 ), zoom: 14.0),
    this.pickUpPLatLng,
    this.destinationLatLng,
    this.pickUpDescription = '',
    this.destinationDescription = '',
    this.markers = const <MarkerId, Marker>{},
    this.polylines = const <PolylineId, Polyline>{},
    this.isBottomSheetExpanded = false,
    this.responseTimeAndDistance,
  });

  ClientMapBookingInfoState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPositionBooking,
    LatLng? pickUpPLatLng,
    LatLng? destinationLatLng,
    String? pickUpDescription,
    String? destinationDescription,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    bool? isBottomSheetExpanded,
    Resource? responseTimeAndDistance,
    

  }) {
    return ClientMapBookingInfoState(
      position: position ?? this.position,
      controller: controller ?? this.controller,
      cameraPositionBooking: cameraPositionBooking ?? this.cameraPositionBooking,
      pickUpPLatLng: pickUpPLatLng ?? this.pickUpPLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpDescription: pickUpDescription ?? this.pickUpDescription,
      destinationDescription: destinationDescription ?? this.destinationDescription,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      isBottomSheetExpanded: isBottomSheetExpanded ?? this.isBottomSheetExpanded,
      responseTimeAndDistance: responseTimeAndDistance ?? this.responseTimeAndDistance,

    );
  }


  @override
  List<Object?> get props => [
    position, 
    controller, 
    markers, 
    cameraPositionBooking, 
    pickUpPLatLng, 
    destinationLatLng, 
    pickUpDescription, 
    destinationDescription, 
    polylines,
    isBottomSheetExpanded,
    responseTimeAndDistance,
    ];
}


// 4.7109886, -74.072092 bogota
// 4.1247564,-73.6502597 villavo