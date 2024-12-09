import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart';
import 'index.dart';




class ClientMapBookingInfoBloc extends Bloc<ClientMapBookingInfoEvent, ClientMapBookingInfoState> {
    
  GeolocatorUseCases geolocatorUseCases;
  ClientMapBookingInfoBloc(this.geolocatorUseCases) : super(const ClientMapBookingInfoState()){
    

   on<ClientMapBookingInfoInitEvent>((event, emit) async {
    final Completer<GoogleMapController> controller = Completer<GoogleMapController>(); 
     emit(
      state.copyWith(
        controller: controller,
        pickUpPLatLng: event.pickUpPLatLng,
        destinationLatLng: event.destinationLatLng,
        pickUpDescription: event.pickUpDescription,
        destinationDescription: event.destinationDescription,
      
      ));
      BitmapDescriptor pickUpDescriptor = await geolocatorUseCases.createMarker.run('assets/img/pickup.png', 40.0, 40.0);
      BitmapDescriptor destinationDescriptor = await geolocatorUseCases.createMarker.run('assets/img/destination-2.png', 40.0, 40.0);
      Marker markerPickUp = geolocatorUseCases.getMarker.run(
        'pickup', 
        state.pickUpPLatLng!.latitude,
        state.pickUpPLatLng!.longitude,
        pickUpDescriptor, 
        'Lugar de recogida',
        'Debes esperar a la recogida'
        );
     Marker markerDestination = geolocatorUseCases.getMarker.run(
        'destination', 
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
        destinationDescriptor, 
        'Destino',
        'listo llegamos'
        );
        emit(
      state.copyWith(
         markers: {
              markerPickUp.markerId: markerPickUp,
              markerDestination.markerId: markerDestination,
            },
      ));
   });

   on<FindMyPositionMapBookingInfo>((event, emit) async {
      Position position = await geolocatorUseCases.findMyPosition.run();
      add(ChangeMapCameraPositionMapBookingInfo(lat: position.latitude, lng: position.longitude));
      emit(
        state.copyWith(
          position: position,
        )
      );
    });

   on<ChangeMapCameraPositionMapBookingInfo>((event, emit) async {
  try {
    GoogleMapController googleMapController = await state.controller!.future;
    final newCameraPosition = CameraPosition(
      target: LatLng(event.lat, event.lng),
      zoom: 14,
      bearing: 0,
    );
    await googleMapController.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    emit(state.copyWith(cameraPositionBooking: newCameraPosition));
  } catch (e) {
    print('ERROR EN ChangeMapCameraPosition: $e');
  }
});

   on<AddPolyline>((event, emit) async {
    List<LatLng> polylineCoordinates = await geolocatorUseCases.getPolyline.run(state.pickUpPLatLng!, state.destinationLatLng!);
    PolylineId id = PolylineId("myroute");
    Polyline polyline = Polyline(
      polylineId: id, 
      color: const Color.fromARGB(255, 243, 159, 90,),
      // color: const Color.fromARGB(255, 230, 254,	83),
      points: polylineCoordinates,
      width: 6,
    );
    emit(
      state.copyWith(
        polylines: {
          id:polyline
        }
      )
    );
  
  });

   on<ToggleBottomSheetEvent>((event, emit) {
    emit(
      state.copyWith(
        isBottomSheetExpanded: event.isBottomSheetExpanded
        ));
    });

  }
 
}
