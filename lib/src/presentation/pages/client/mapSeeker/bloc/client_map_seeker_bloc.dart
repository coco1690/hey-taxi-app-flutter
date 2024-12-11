import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/models/placemark_data.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart';
import 'package:hey_taxi_app/src/domain/usecase/socket/socket_usecases.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'client_map_seeker_event.dart';
import 'client_map_seeker_state.dart';



class ClientMapSeekerBloc extends Bloc<ClientMapSeekerEvent, ClientMapSeekerState> {
    
  GeolocatorUseCases geolocatorUseCases;
  SocketUseCases socketUseCases;
  ClientMapSeekerBloc(this.geolocatorUseCases, this.socketUseCases) : super(const ClientMapSeekerState()){
    

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

  on<OnFocusTextField>((event, emit) async  {
    print("Evento OnFocusTextField recibido");
    emit(state.copyWith(shouldExpandSheet: true));

    //  // Restablece el estado después de un breve tiempo para permitir futuras expansiones
    // await Future.delayed(const Duration(milliseconds: 500), ()  {
    // print('Evento OnFocusTextField: Restableciendo el estado');
    // emit(state.copyWith(shouldExpandSheet: false));
    // });

  });

  on<ConnectSocketIo>((event, emit) async {
    Socket socket = await socketUseCases.connect.run();
    emit(state.copyWith(socket: socket));
    add(ListenDriversPositionSocketIo());
    add(ListenDriverDisconnectedSocketIo());
   });

  on<DisconnectSocketIo>((event, emit) async {
    Socket socket = await socketUseCases.disconnect.run();
    emit(state.copyWith( socket: socket ));
   });

  on<ListenDriversPositionSocketIo>((event, emit) async {
    state.socket?.on('new_driver_position', (data) {
      print('Recibido datos de posicion del driver');
      print('Id:  ${data['id_socket']}');
      print('Id:  ${data['id']}');
      print('Lat: ${data['lat']}');
      print('Lng: ${data['lng']}');    
      add(AddDriverPositionMarker(
        idSocket: data['id_socket'] as String,
        idDriver: data['id'], 
        lat:      data['lat'] as double, 
        lng:      data['lng'] as double,
      ));  
    });
   });

   on<ListenDriverDisconnectedSocketIo>((event, emit) async{
     
     state.socket?.on('driver_disconnected', (data) {
      print('eliminado datos de posicion del driver');
      print('Id:  ${data['id_socket']}'
      );
      add(RemoveDriverPositionMarker(
        idSocket: data['id_socket'] as String,
      ));
    });
   });

   on<RemoveDriverPositionMarker>((event, emit) async {
    final deleteMarkers =  Map<MarkerId, Marker>.of(state.markers)..remove(MarkerId ( event.idSocket));
    if( !emit.isDone ){ // Verifica si puedes emitir antes de hacerlo
    emit(
      state.copyWith( 
        markers: deleteMarkers 
      ));
    }
   });
  
   on<AddDriverPositionMarker>((event, emit) async {
    BitmapDescriptor imageMarker = await geolocatorUseCases.createMarker.run('assets/img/taxi-2.png', 40.0, 40.0);
    Marker marker = geolocatorUseCases.getMarker.run(
        event.idSocket,
        event.lat,
        event.lng,
        imageMarker, 
        'Conductor disponible',
        ''
        );
        final updateMarkers = Map<MarkerId, Marker>.of(state.markers)..[marker.markerId] = marker;
      if( !emit.isDone ){ // Verifica si puedes emitir antes de hacerlo
    emit(
      state.copyWith(
        markers: updateMarkers,
      )
    );
    }
   });
   
  on<ResetExpandSheetEvent>((event, emit) {
  emit(state.copyWith(shouldExpandSheet: false));
});
 
 

  }
 
}
