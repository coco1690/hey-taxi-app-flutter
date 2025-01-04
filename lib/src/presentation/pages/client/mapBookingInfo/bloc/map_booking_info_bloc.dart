import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/bloc_socketIo/index.dart';
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
  BlocSocketIO blocSocketIO;


  ClientMapBookingInfoBloc(this.geolocatorUseCases, this.blocSocketIO, this.clientRequestUseCases, this.authUseCases,) : super(const ClientMapBookingInfoState()){
    

  //  on<ClientMapBookingInfoInitEvent>((event, emit) async {
  //   final Completer<GoogleMapController> controller = Completer<GoogleMapController>(); 
  //    emit(
  //     state.copyWith(
  //       controller: controller,
  //       pickUpLatlng: event.pickUpLatlng,
  //       destinationLatLng: event.destinationLatLng,
  //       pickUpDescription: event.pickUpDescription,
  //       destinationDescription: event.destinationDescription,
      
  //     ));
  //     BitmapDescriptor pickUpDescriptor = await geolocatorUseCases.createMarker.run('assets/img/pickup.png', 40.0, 40.0);
  //     BitmapDescriptor destinationDescriptor = await geolocatorUseCases.createMarker.run('assets/img/destination-2.png', 40.0, 40.0);
  //     Marker markerPickUp = geolocatorUseCases.getMarker.run(
  //       'pickup', 
  //       state.pickUpLatlng!.latitude,
  //       state.pickUpLatlng!.longitude,
  //       pickUpDescriptor, 
  //       'Lugar de recogida',
  //       'Debes esperar a la recogida'
  //       );
  //    Marker markerDestination = geolocatorUseCases.getMarker.run(
  //       'destination', 
  //       state.destinationLatLng!.latitude,
  //       state.destinationLatLng!.longitude,
  //       destinationDescriptor, 
  //       'Destino',
  //       'listo llegamos'
  //       );
  //       emit(
  //     state.copyWith(
  //        markers: {
  //             markerPickUp.markerId: markerPickUp,
  //             markerDestination.markerId: markerDestination,
  //           },
  //     ));
  //  });


   on<ClientMapBookingInfoInitEvent>((event, emit) async {
      // Verifica si ya está inicializado
      // if (state.isInitialized) return;

      final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(
        state.copyWith(
          controller: controller,
          pickUpLatlng: event.pickUpLatlng,
          destinationLatLng: event.destinationLatLng,
          pickUpDescription: event.pickUpDescription,
          destinationDescription: event.destinationDescription,
          // isInitialized: true, // Marca como inicializado
        )
      );

      BitmapDescriptor pickUpDescriptor = await geolocatorUseCases.createMarker.run('assets/img/pickup.png', 40.0, 40.0);
      BitmapDescriptor destinationDescriptor = await geolocatorUseCases.createMarker.run('assets/img/destination-2.png', 40.0, 40.0);

      Marker markerPickUp = geolocatorUseCases.getMarker.run(
        'pickup',
        state.pickUpLatlng!.latitude,
        state.pickUpLatlng!.longitude,
        pickUpDescriptor,
        'Lugar de recogida',
        'Debes esperar a la recogida',
      );

      Marker markerDestination = geolocatorUseCases.getMarker.run(
        'destination',
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
        destinationDescriptor,
        'Destino',
        'listo llegamos',
      );

      emit(
        state.copyWith(
          markers: {
            markerPickUp.markerId: markerPickUp,
            markerDestination.markerId: markerDestination,
          },
        )
      );
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
      if (state.controller != null && !state.controller!.isCompleted) {
        GoogleMapController googleMapController = await state.controller!.future;
        final newCameraPosition = CameraPosition(
          target: LatLng(event.lat, event.lng),
          zoom: 14,
          bearing: 0,
        );
        await googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(newCameraPosition),
        );
        emit(state.copyWith(cameraPositionBooking: newCameraPosition));
      }
    } catch (e) {
      print('ERROR EN ChangeMapCameraPosition: $e');
    }
  });


//    on<ChangeMapCameraPositionMapBookingInfo>((event, emit) async {
//   try {
//     GoogleMapController googleMapController = await state.controller!.future;
//     final newCameraPosition = CameraPosition(
//       target: LatLng(event.lat, event.lng),
//       zoom: 14,
//       bearing: 0,
//     );
//     await googleMapController.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
//     emit(state.copyWith(cameraPositionBooking: newCameraPosition));
//   } catch (e) {
//     print('ERROR EN ChangeMapCameraPosition: $e');
//   }
// });


   on<AddPolyline>((event, emit) async {
    List<LatLng> polylineCoordinates = await geolocatorUseCases.getPolyline.run(
      state.pickUpLatlng!, 
      state.destinationLatLng!
    );
    
    PolylineId id = const PolylineId("myroute");
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
          ...state.polylines,
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
      state.pickUpLatlng!.latitude, 
      state.pickUpLatlng!.longitude, 
      state.destinationLatLng!.latitude, 
      state.destinationLatLng!.longitude,
      state.recommendedValue ?? 0

    );
    emit(
      state.copyWith(
        responseTimeAndDistance: timeAndDistanceValues
        ));
      
    });

  // ####################### Crear la solicitud de viaje al driver ###############################
  on<CreateClientRequest>((event, emit) async {
  try {
    AuthResponseModel authResponseModel = await authUseCases.getUserSession.run();
     Resource<TimeAndDistanceValues> timeAndDistanceResponse = await clientRequestUseCases.getTimeAndDistanceClientRequest.run(
      state.pickUpLatlng!.latitude,
      state.pickUpLatlng!.longitude,
      state.destinationLatLng!.latitude,
      state.destinationLatLng!.longitude,
      state.recommendedValue ?? 0, // Valor por defecto
    );

    int? recommendedValue = 0;

    if (timeAndDistanceResponse is Succes<TimeAndDistanceValues>) {
      recommendedValue = timeAndDistanceResponse.data.recommendedValue as int;
    } else {
      print('Error obteniendo valores recomendados');
    }
    // Validación segura para fareOffered
     // Validación segura para fareOffered
    int fareOffered = 0; // Valor por defecto
    if (state.fareOffered?.value != null && state.fareOffered!.value.isNotEmpty) {
      fareOffered = int.tryParse(state.fareOffered!.value) ?? recommendedValue;
    } else {
      fareOffered = recommendedValue;
    }

    Resource<bool> response = await clientRequestUseCases.createClientRequest.run(
      ClientRequest(
        idClient: authResponseModel.user.id!,
        fareOffered: fareOffered,
        detailsLocation: state.detailsLocation?.value ?? '',
        pickupDescription: state.pickUpDescription,
        destinationDescription: state.destinationDescription,
        pickupLat: state.pickUpLatlng!.latitude,
        pickupLng: state.pickUpLatlng!.longitude,
        destinationLat: state.destinationLatLng!.latitude,
        destinationLng: state.destinationLatLng!.longitude,
      ),
    );

    emit(
      state.copyWith(
        responseClientRequest: response,
      ),
    );
  } catch (error) {
    print('Error al crear la solicitud: $error');
    emit(state.copyWith(responseClientRequest: ErrorData('Error al crear la solicitud')));
  }
});

    //######################### Emite la solicitud de viaje al driver ###############################
   on<EmitNewClientRequestSocketIO>((event, emit) async { 
     blocSocketIO.state.socket?.emit('new_client_request',{
      'id_client_request': 85
     });
   });


   on<FareOfferedOnChanged>((event, emit) async {
    emit(
      state.copyWith( fareOffered: BlocFormItem(
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
   
   // Reinicia el estado
   on<ResetStateEvent>((event, emit) async {
    emit(const ClientMapBookingInfoState()); // Reinicia el estado
  });
  
   // Centrar el mapa en la ubicación del usuario
   on<CenterMapOnUserLocation>((event, emit) async {
      try {
        // Si no hay una posición actual, intenta obtenerla
        if (state.position == null) {
  
          Position position = await geolocatorUseCases.findMyPosition.run();
          emit(state.copyWith(position: position));
        }

        // Obtén la posición actual del estado
        final position = state.position;
        if (position == null) {
          print('No se pudo obtener la posición actual del usuario DESDE MAPBOOKINGINFOBLOC');
          return;
        }

        // Anima la cámara para centrar el mapa en la posición actual
        GoogleMapController controller = await state.controller!.future;
        final newCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.0, // Ajusta el nivel de zoom según sea necesario
        );
        await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
      } catch (e) {
        print('Error al centrar el mapa desde MapBookingInfoBloc: $e');
      }
    });

  }
 
}
