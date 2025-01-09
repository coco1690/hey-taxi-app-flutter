import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/bloc_socketIo/index.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/models/client_request_response.dart';
import 'package:hey_taxi_app/src/domain/models/driver_position.dart';
import 'package:hey_taxi_app/src/domain/models/driver_trip_request.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/index.dart';
import 'package:hey_taxi_app/src/domain/usecase/client-request/client_request_usecases.dart';
import 'package:hey_taxi_app/src/domain/usecase/driver-trip-request/index.dart';
import 'package:hey_taxi_app/src/domain/usecase/driver_position/index.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'driver_client_requests_event.dart';
import 'driver_client_requests_state.dart';



class DriverClientRequestsBloc extends Bloc<DriverClientRequestsEvent, DriverClientRequestsState> {

  AuthUseCases authUseCases; // LO INVOCO PARA OBTENER LA ID DEL DRIVER
  ClientRequestUseCases clientRequestUseCases;
  DriverPositionUseCases driverPositionUseCases;
  DriverTripRequestUseCases driverTripRequestUseCases;
  BlocSocketIO blocSocketIO;

  DriverClientRequestsBloc( this.clientRequestUseCases, this.blocSocketIO, this.driverPositionUseCases, this.authUseCases, this.driverTripRequestUseCases ) : super(const DriverClientRequestsState()){


    on<InitDriverClientRequests>((event, emit) async {
      AuthResponseModel authResponseModel = await authUseCases.getUserSession.run();// OBTENGO LA ID DEL DRIVER
      Resource responseDriverPosition = await driverPositionUseCases.getDriverPosition.run(authResponseModel.user.id!);

      emit(state.copyWith(
        response: Loading(),
        idDriver: authResponseModel.user.id,
        responseDriverPosition: responseDriverPosition
        ));
      add(GetNearbyClientRequest());
    });

    on<GetNearbyClientRequest>((event, emit) async {
      final responseDriverPosition = state.responseDriverPosition;
      if( responseDriverPosition is Succes ){
        DriverPosition driverPosition = responseDriverPosition.data as DriverPosition;
        Resource<List<ClientRequestResponse>> response = await clientRequestUseCases.getNearbyClientRequestResponse.run(driverPosition.lat, driverPosition.lng);
        
        if (response is Succes<List<ClientRequestResponse>>) {
        if (response.data.isEmpty) {
          print('La lista de ClientRequestResponse está vacía');
        } else {
        for (var req in response.data) {
        print('ClientRequest: id=${req.id}, status=${req.status}');
       }
      }
     }
        emit(state.copyWith(response: response));
      }
      
    });

    on<CreateDriverTripRequest>((event, emit) async {
      Resource<DriverTripRequest> response = await driverTripRequestUseCases.createDriverTripRequest.run(event.driverTripRequest);
     
      emit(state.copyWith(responseCreateDriverTripRequest: response));
      
    });

    //######################### Escucha los cambio de las solicitudes de los clientes ###############################
    on<ListenNewClientRequestSocketIO>((event, emit) async {
      if ( blocSocketIO.state.socket != null ){
      blocSocketIO.state.socket?.on('created_client_request', (data) {
        add(GetNearbyClientRequest());
      });
      } else {
        print('Socket no inicializado');
      }
    });

    
  }
}