import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart';
import 'package:hey_taxi_app/src/domain/usecase/socket/socket_usecases.dart';
import 'package:socket_io_client/socket_io_client.dart';


import 'index.dart';

class DriverMapLocationBloc extends Bloc<DriverMapLocationEvent, DriverMapLocationState> {
  
  SocketUseCases socketUseCases;
  GeolocatorUseCases geolocatorUseCases;
  StreamSubscription<Position>? positionStreamSubscription;

  DriverMapLocationBloc(this.geolocatorUseCases, this.socketUseCases) : super(const DriverMapLocationState()){
    

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

     add(AddMyPositionMarker(lat: position.latitude, lng: position.longitude));

     Stream<Position> positionStream =  geolocatorUseCases.getPositionStream.run();
     positionStreamSubscription =  positionStream.listen((Position position){
        add(UpdateLocation(position: position));
      });
        emit(
          state.copyWith(
            position: position, 
          )
        );
      
    print('Desde el DriverMapLocationBloc: ${position.latitude}, ${position.longitude}');
  });

   on<AddMyPositionMarker>((event, emit) async {
    BitmapDescriptor imageMarker = await geolocatorUseCases.createMarker.run('assets/img/driver_pin.png', 40.0, 40.0);
    Marker marker = geolocatorUseCases.getMarker.run(
        'MyLocation', 
        event.lat,
        event.lng,
        imageMarker, 
        'Mi Posicion',
        ''
        );
    emit(
      state.copyWith(
        markers: {
          marker.markerId: marker
        },

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

   on<OnUpdateStatedestinatio>((event, emit) async {
    emit(state.copyWith(
      isUpdateStatedestinatio: event.isUpdateStatedestinatio
      ));
  });
  
   on<UpdateLocation>((event, emit) async {
    print('ACTUALIZACION DE LOCALIZACION LAT: ${event.position.latitude} LNG: ${event.position.longitude}');
    add(AddMyPositionMarker(lat: event.position.latitude, lng: event.position.longitude));
    add(ChangeMapCameraPosition(lat: event.position.latitude, lng: event.position.longitude));
    emit(state.copyWith(
      position: event.position,
    ));
  });
  
   on<StopLocation>((event, emit) async {
    positionStreamSubscription?.cancel();
  });

   on<ConnectSocketIo>((event, emit) async {
    Socket socket = await socketUseCases.connect.run();
    emit(state.copyWith(socket: socket));  
   });

   on<DisconnectSocketIo>((event, emit) async {
    Socket socket = await socketUseCases.disconnect.run();
    emit(state.copyWith( socket: socket ));
   });
  
   on<EmitDriverPositionSoketIo>((event, emit) async {
     state.socket?.emit('new_driver_position');
   });
 
  }

 
}
