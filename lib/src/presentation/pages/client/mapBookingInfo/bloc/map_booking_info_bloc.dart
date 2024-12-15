import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/models/client_request.dart';
import 'package:hey_taxi_app/src/domain/models/time_and_distance_values.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/index.dart';
import 'package:hey_taxi_app/src/domain/usecase/client-request/client_request_usecases.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';
import 'index.dart';




class ClientMapBookingInfoBloc extends Bloc<ClientMapBookingInfoEvent, ClientMapBookingInfoState> {
    
  GeolocatorUseCases geolocatorUseCases;
  ClientRequestUseCases clientRequestUseCases;
  AuthUseCases authUseCases;

  ClientMapBookingInfoBloc(this.geolocatorUseCases, this.clientRequestUseCases, this.authUseCases) : super(const ClientMapBookingInfoState()){
    

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
   
   on<GetTimeAndDistanceValues>((event, emit) async {
    emit(
      state.copyWith(
        responseTimeAndDistance: Loading()
        ));
    Resource<TimeAndDistanceValues> timeAndDistanceValues = await clientRequestUseCases.getTimeAndDistanceClientRequest.run(
      state.pickUpPLatLng!.latitude, 
      state.pickUpPLatLng!.longitude, 
      state.destinationLatLng!.latitude, 
      state.destinationLatLng!.longitude
    );
    emit(
      state.copyWith(
        responseTimeAndDistance: timeAndDistanceValues
        ));
    });

   on<CreateClientRequest>((event, emit) async {
       AuthResponseModel authResponseModel =await authUseCases.getUserSession.run();
       Resource<bool> response = await clientRequestUseCases.createClientRequest.run( 
        ClientRequest(
          idClient:  authResponseModel.user.id!,
          // fareOffered: fareOffered,
          // detailsLocation: state.detailsLocation?.value ?? '',
          pickupDescription: state.pickUpDescription,
          destinationDescription: state.destinationDescription,
          pickupLat: state.pickUpPLatLng!.latitude,
          pickupLng: state.pickUpPLatLng!.longitude,
          destinationLat: state.destinationLatLng!.latitude,
          destinationLng: state.destinationLatLng!.longitude,
        ));
        emit(
          state.copyWith(
            responseClientRequest: response
          ));

    });

   on<FareOfferedOnChanged>((event, emit) async {
    emit(
      state.copyWith( fareOfeered: BlocFormItem(
        value: event.fareOfeered?.value == null ? '' : event.fareOfeered?.value ?? '',
        error: event.fareOfeered?.error ?? '',
      ),
        ));
    });

   on<DetailsLocationOnChanged>((event, emit) async {
    emit(
      state.copyWith( detailsLocation: BlocFormItem(
        value: event.detailsLocation?.value == null ? '' : event.detailsLocation?.value ?? '',
        error: event.detailsLocation?.error ?? '',
      ),
        
        ));
    });



  }
 
}
