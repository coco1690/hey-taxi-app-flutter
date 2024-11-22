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


  }
 
}
