import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/models/placemark_data.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart';
import 'client_map_seeker_event.dart';
import 'client_map_seeker_state.dart';



class ClientMapSeekerBloc extends Bloc<ClientMapSeekerEvent, ClientMapSeekerState> {
    
  GeolocatorUseCases geolocatorUseCases;
  ClientMapSeekerBloc(this.geolocatorUseCases) : super(const ClientMapSeekerState()){
    

   on<ClientMapSeekerInitEvent>((event, emit) async {
    final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
     emit(
      state.copyWith(
        controller: controller
      ));
   });

  //  on<FindMyPosition>((event, emit) async {
  //   Position position = await geolocatorUseCases.findMyPosition.run();
  //    add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));
  //    BitmapDescriptor imageMarker = await geolocatorUseCases.createMarker.run('assets/img/gps-2.png');
  //    Marker marker = geolocatorUseCases.getMarker.run(
  //       'MyLocation', 
  //       position.latitude,
  //       position.longitude,
  //       imageMarker, 
  //       'Mi Posicion',
  //       ''
  //       );
  //       emit(
  //         state.copyWith(
  //           position: position, 
  //           markers: {
  //             marker.markerId: marker
  //           },

  //         )
  //       );
      
  //   print('Desde el clientmapseekerbloc: ${position.latitude}, ${position.longitude}');
  // });

   on<FindMyPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findMyPosition.run();
      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));
      emit(
        state.copyWith(
          position: position,
        )
      );
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

   on<OnCameraIdle>((event, emit) async {
  try {
    PlacemarkData placemarkData = await geolocatorUseCases.getPlacemarkData.run(state.cameraPosition);
    emit(state.copyWith(placemarkData: placemarkData));
  } catch (e) {
    print('ERROR EN OnCameraIdle: $e');
  }
});

   on<OnGoogleAutocompletepickUpSelected>((event, emit) async {
    emit(state.copyWith(
      pickUpPLatLng: LatLng(event.lat, event.lng),
      pickUpDescription: event.pickUpDescription
      ));
  });

   on<OnGoogleAutocompleteDestinationSelected>((event, emit) async {
    emit(state.copyWith(
      destinationLatLng: LatLng(event.lat, event.lng),
      destinationDescription: event.destinationDescription
      ));
  });

  on<OnUpdaateButtonEstate>((event, emit) async {
    emit(state.copyWith(
      isButtonEnabled: event.isButtonEnabled
      ));
  });

  on<OnUpdateStatedestinatio>((event, emit) async {
    emit(state.copyWith(
      isUpdateStatedestinatio: event.isUpdateStatedestinatio
      ));
  });

  }
 
}
