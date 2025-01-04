

import 'package:hey_taxi_app/src/data/dataSource/remote/service/driver_trip_request_service.dart';
import 'package:hey_taxi_app/src/domain/models/driver_trip_request.dart';

import 'package:hey_taxi_app/src/domain/utils/resource.dart';

import '../../domain/repository/driver_trip_request_repository.dart';

class DriverTripRequestRepositoryImple implements DriverTripRequestRepository {

  DriverTripRequestService driverTripRequestService;

  DriverTripRequestRepositoryImple( this.driverTripRequestService );

  @override
  Future<Resource<DriverTripRequest>> create(DriverTripRequest driverTripRequest) {
    return driverTripRequestService.create(driverTripRequest);
  }

}