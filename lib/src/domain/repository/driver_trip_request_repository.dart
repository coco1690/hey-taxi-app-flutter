import 'package:hey_taxi_app/src/domain/utils/resource.dart';

import '../models/driver_trip_request.dart';

abstract class DriverTripRequestRepository {

  Future<Resource<DriverTripRequest>> create( DriverTripRequest driverTripRequest);

}