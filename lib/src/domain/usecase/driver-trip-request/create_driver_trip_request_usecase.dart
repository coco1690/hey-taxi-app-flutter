

import 'package:hey_taxi_app/src/domain/models/driver_trip_request.dart';
import 'package:hey_taxi_app/src/domain/repository/driver_trip_request_repository.dart';

class CreateDriverTripRequestUseCase {

  DriverTripRequestRepository driverTripRequestRepository;

  CreateDriverTripRequestUseCase( this.driverTripRequestRepository );

  run(DriverTripRequest driverTripRequest) => driverTripRequestRepository.create(driverTripRequest);

}