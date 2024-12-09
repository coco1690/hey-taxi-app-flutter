

import 'package:hey_taxi_app/src/domain/repository/socket_repository.dart';

class ConnectSocketUseCase {
  
  SocketRepository socketRepository;

  ConnectSocketUseCase(this.socketRepository);

  run() => socketRepository.connect();
  
}