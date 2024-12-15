

import 'package:hey_taxi_app/src/domain/models/client_request.dart';

import '../../domain/models/time_and_distance_values.dart';
import '../../domain/repository/index.dart';
import '../../domain/utils/resource.dart';
import '../dataSource/remote/service/client_request_service.dart';

class ClientRequestRepositoryImple implements ClientRequestRepository {
  
  ClientRequestService clientRequestService;

  ClientRequestRepositoryImple( this.clientRequestService );

  @override
  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequest(double originLat, double originLng, double destinationLat, double destinationLng) {
    
    return clientRequestService.getTimeAndDistanceClientRequest(originLat, originLng, destinationLat, destinationLng);
  }

  @override
  Future<Resource<bool>> create(ClientRequest clientRequest) {
    return clientRequestService.create(clientRequest);
  }

} 