import 'package:hey_taxi_app/src/domain/usecase/client-request/create_client_request_usecase.dart';
import 'package:hey_taxi_app/src/domain/usecase/client-request/get_nearby_client_request_response_usecase.dart';

import 'index.dart';

class ClientRequestUseCases {

  GetNearbyClientRequestResponseUsecase getNearbyClientRequestResponse;
  GetTimeAndDistanceClientRequestUseCase getTimeAndDistanceClientRequest;
  CreateClientRequestUsecase createClientRequest;


  ClientRequestUseCases({
    required this.getNearbyClientRequestResponse,
    required this.getTimeAndDistanceClientRequest,
    required this.createClientRequest,
  });
}