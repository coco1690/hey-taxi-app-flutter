import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/models/placemark_data.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart';
import 'index.dart';



class ClientDestinationMapBloc extends Bloc<ClientDestinationMapEvent, ClientDestinationMapState> {
    
  GeolocatorUseCases geolocatorUseCases;
  ClientDestinationMapBloc(this.geolocatorUseCases) : super(const ClientDestinationMapState()){
    

   on<ClientDestinationMapInitEvent>((event, emit) async {
    final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
     emit(state.copyWith(controller: controller));
   });

   on<FindMyPositionDestinationMap>((event, emit) async {
    Position position = await geolocatorUseCases.findMyPosition.run();
     add(ChangeMapCameraPositionDestination(lat: position.latitude, lng: position.longitude));
     BitmapDescriptor imageMarker = await geolocatorUseCases.createMarker.run('assets/img/gps-2.png');
     Marker marker = geolocatorUseCases.getMarker.run(
        'MyLocation', 
        position.latitude,
        position.longitude,
        imageMarker, 
        'Mi Posicion',
        ''
        );
        emit(
          state.copyWith(
            position: position, 
            markers: {
              marker.markerId: marker
            },

          )
        );
      
    print('Desde el clientmapseekerbloc: ${position.latitude}, ${position.longitude}');
  });

   on<ChangeMapCameraPositionDestination>((event, emit) async {
  try {
    GoogleMapController googleMapController = await state.controller!.future;
    final newCameraPosition = CameraPosition(
      target: LatLng(event.lat, event.lng),
      zoom: 14,
      bearing: 0,
    );
    await googleMapController.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    emit(state.copyWith(cameraPositionDestination: newCameraPosition));
  } catch (e) {
    print('ERROR EN ChangeMapCameraPosition: $e');
  }
});

   on<OnCameraMoveDestination>((event, emit) async {
     emit(state.copyWith(cameraPositionDestination: event.cameraPosition));
   });

   on<OnCameraIdleDestination>((event, emit) async {
     PlacemarkData placemarkData = await geolocatorUseCases.getPlacemarkData.run(state.cameraPositionDestination);
     emit(state.copyWith(
      placemarkData: placemarkData,
      // destinationLatLng: LatLng(event.lat, event.lng),
      // destinationDescription: event.destinationDescription,
    ));
   });

   on<OnGoogleAutocompletepickUpSelectedDestination>((event, emit) async {
    emit(state.copyWith(
      pickUpPLatLng: LatLng(event.lat, event.lng),
      pickUpDescription: event.pickUpDescription
      ));
  });

   on<OnGoogleAutocompleteSelectedDestinationMap>((event, emit) async {
    emit(state.copyWith(
      destinationLatLng: LatLng(event.lat, event.lng),
      destinationDescription: event.destinationDescription
      ));
  });

  }
 
}
