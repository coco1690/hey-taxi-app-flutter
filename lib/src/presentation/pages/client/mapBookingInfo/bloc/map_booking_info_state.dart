import 'dart:async';
 
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';



class ClientMapBookingInfoState extends Equatable {
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPositionBooking;
  final LatLng? pickUpLatlng;
  final LatLng? destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines ;
  final bool isBottomSheetExpanded;
  final Resource? responseTimeAndDistance;
  final Resource? responseClientRequest;
  final BlocFormItem? fareOfeered;
  final BlocFormItem? detailsLocation;
  final bool isInitialized;

  const ClientMapBookingInfoState({
    this.position,
    this.controller,
    this.cameraPositionBooking = const CameraPosition(target: LatLng(4.1247564,-73.6502597 ), zoom: 14.0),
    this.pickUpLatlng,
    this.destinationLatLng,
    this.pickUpDescription = '',
    this.destinationDescription = '',
    this.markers = const <MarkerId, Marker>{},
    this.polylines = const <PolylineId, Polyline>{},
    this.isBottomSheetExpanded = false,
    this.responseTimeAndDistance,
    this.responseClientRequest,
    this.fareOfeered,
    this.detailsLocation,
    this.isInitialized = false,

  });

  ClientMapBookingInfoState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPositionBooking,
    LatLng? pickUpLatlng,
    LatLng? destinationLatLng,
    String? pickUpDescription,
    String? destinationDescription,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    bool? isBottomSheetExpanded,
    Resource? responseTimeAndDistance,
    Resource? responseClientRequest,
    BlocFormItem? fareOfeered,
    BlocFormItem? detailsLocation,
    bool? isInitialized,

    

  }) {
    return ClientMapBookingInfoState(
      position: position ?? this.position,
      controller: controller ?? this.controller,
      cameraPositionBooking: cameraPositionBooking ?? this.cameraPositionBooking,
      pickUpLatlng: pickUpLatlng ?? this.pickUpLatlng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpDescription: pickUpDescription ?? this.pickUpDescription,
      destinationDescription: destinationDescription ?? this.destinationDescription,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      isBottomSheetExpanded: isBottomSheetExpanded ?? this.isBottomSheetExpanded,
      responseTimeAndDistance: responseTimeAndDistance ?? this.responseTimeAndDistance,
      responseClientRequest: responseClientRequest ?? this.responseClientRequest,
      fareOfeered: fareOfeered ?? this.fareOfeered,
      detailsLocation: detailsLocation ?? this.detailsLocation,
      isInitialized: isInitialized ?? this.isInitialized,

    );
  }


  @override
  List<Object?> get props => [
    position, 
    controller, 
    markers, 
    cameraPositionBooking, 
    pickUpLatlng, 
    destinationLatLng, 
    pickUpDescription, 
    destinationDescription, 
    polylines,
    isBottomSheetExpanded,
    responseTimeAndDistance,
    responseClientRequest,
    fareOfeered,
    detailsLocation,
    isInitialized,
    ];
}


// 4.7109886, -74.072092 bogota
// 4.1247564,-73.6502597 villavo