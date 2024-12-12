



import 'package:hey_taxi_app/src/domain/models/time_and_distance_values.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';

abstract class ClientRequestRepository {
  
  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequest(

    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
    
    );

}