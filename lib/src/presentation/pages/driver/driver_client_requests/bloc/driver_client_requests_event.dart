import 'package:hey_taxi_app/src/domain/models/driver_trip_request.dart';

abstract class DriverClientRequestsEvent {}

class InitDriverClientRequests extends DriverClientRequestsEvent {}

class GetNearbyClientRequest extends DriverClientRequestsEvent {}

class CreateDriverTripRequest extends DriverClientRequestsEvent {
  final DriverTripRequest driverTripRequest;

  CreateDriverTripRequest({required this.driverTripRequest});
}

class FareOfferedOnChanged extends DriverClientRequestsEvent {
  final int fareOffered;
  FareOfferedOnChanged({required this.fareOffered});
}

class ListenNewClientRequestSocketIO extends DriverClientRequestsEvent {}