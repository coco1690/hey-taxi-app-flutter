

import 'package:hey_taxi_app/src/domain/repository/socket_repository.dart';

class DisconnectSocketUsecase { 
  
  SocketRepository socketRepository;

  DisconnectSocketUsecase(this.socketRepository);

  run() => socketRepository.disconnect();
  
}