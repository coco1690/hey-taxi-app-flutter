
import '../../repository/client_request_repository.dart';

class GetTimeAndDistanceClientRequestUseCase {

  ClientRequestRepository clientRequestRepository;

  GetTimeAndDistanceClientRequestUseCase( this.clientRequestRepository );

  run(double originLat, double originLng, double destinationLat, double destinationLng) => clientRequestRepository.getTimeAndDistanceClientRequest(originLat, originLng, destinationLat, destinationLng);
}