import 'package:hey_taxi_app/src/domain/usecase/client-request/create_client_request_usecase.dart';

import 'index.dart';

class ClientRequestUseCases {

  GetTimeAndDistanceClientRequestUseCase getTimeAndDistanceClientRequest;
  CreateClientRequestUsecase createClientRequest;

  ClientRequestUseCases({
    required this.getTimeAndDistanceClientRequest,
    required this.createClientRequest,
  });
}