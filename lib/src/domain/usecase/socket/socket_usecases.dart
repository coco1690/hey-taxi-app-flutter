

import 'package:hey_taxi_app/src/domain/usecase/socket/connect_socket_usecase.dart';
import 'package:hey_taxi_app/src/domain/usecase/socket/disconnect_socket_usecase.dart';

class SocketUseCases {
  
  ConnectSocketUseCase connect;
  DisconnectSocketUsecase disconnect;

  SocketUseCases({
    required this.connect,
    required this.disconnect,
  });
}