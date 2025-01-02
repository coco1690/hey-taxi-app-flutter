
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/usecase/socket/index.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'index.dart';

class BlocSocketIO extends Bloc<BlocSocketIoEvent, BlocSocketIoState> {

  SocketUseCases socketUseCases;

  BlocSocketIO( this.socketUseCases) : super(const BlocSocketIoState()){

      on<ConnectSocketIo>((event, emit)  {
    Socket socket =  socketUseCases.connect.run();
    emit(state.copyWith(socket: socket));  
   });

    on<DisconnectSocketIo>((event, emit) {
    socketUseCases.disconnect.run();
    emit(state.copyWith( socket: null ));
   });


  }
}