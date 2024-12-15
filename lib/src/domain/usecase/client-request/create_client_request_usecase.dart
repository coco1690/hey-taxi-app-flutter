import 'package:hey_taxi_app/src/domain/models/client_request.dart';
import 'package:hey_taxi_app/src/domain/repository/index.dart';

class CreateClientRequestUsecase {

  ClientRequestRepository clientRequestRepository;

  CreateClientRequestUsecase( this.clientRequestRepository );

  run(ClientRequest clientRequest) => clientRequestRepository.create(clientRequest);
  
}