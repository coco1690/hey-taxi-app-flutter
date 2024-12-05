import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart';

import 'index.dart';

class DriverMapLocationBloc extends Bloc<DriverMapLocationEvent, DriverMapLocationState> {
    
  GeolocatorUseCases geolocatorUseCases;
  DriverMapLocationBloc(this.geolocatorUseCases) : super(const DriverMapLocationState()){
    

   on<DriverMapLocationInitEvent>((event, emit) async {
    final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
     emit(
      state.copyWith(
        controller: controller
      ));
   });

   on<FindMyPosition>((event, emit) async {
    Position position = await geolocatorUseCases.findMyPosition.run();
     add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));
     BitmapDescriptor imageMarker = await geolocatorUseCases.createMarker.run('assets/img/gps-4.png', 50.0, 50.0);
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
      
    print('Desde el DriverMapLocationBloc: ${position.latitude}, ${position.longitude}');
  });

   on<ChangeMapCameraPosition>((event, emit) async {
  try {
    GoogleMapController googleMapController = await state.controller!.future;
    final newCameraPosition = CameraPosition(
      target: LatLng(event.lat, event.lng),
      zoom: 14,
      bearing: 0,
    );
    await googleMapController.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    emit(state.copyWith(cameraPosition: newCameraPosition));
  } catch (e) {
    print('ERROR EN ChangeMapCameraPosition: $e');
  }
});

   on<OnCameraMove>((event, emit) async {
     emit(state.copyWith(cameraPosition: event.cameraPosition));
   });

   on<OnUpdateStatedestinatio>((event, emit) async {
    emit(state.copyWith(
      isUpdateStatedestinatio: event.isUpdateStatedestinatio
      ));
  });

  }
 
}
