
import '../../repository/index.dart';

class GetNearbyClientRequestResponseUsecase {

    ClientRequestRepository clientRequestRepository;

  GetNearbyClientRequestResponseUsecase( this.clientRequestRepository );

  run(double driverLat, double driverLng) => clientRequestRepository.getNearbyTripRequest(driverLat, driverLng);
}