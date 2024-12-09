

import 'package:geolocator/geolocator.dart';

abstract class DriverMapLocationEvent {}

class DriverMapLocationInitEvent extends DriverMapLocationEvent {}
class FindMyPosition extends DriverMapLocationEvent {}
class FindMyPositionSelectionMap extends DriverMapLocationEvent {}

class ChangeMapCameraPosition extends DriverMapLocationEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({required this.lat, required this.lng});
}

class OnUpdateStatedestinatio extends DriverMapLocationEvent {
  final bool isUpdateStatedestinatio;
  OnUpdateStatedestinatio({required this.isUpdateStatedestinatio});
}

class UpdateLocation extends DriverMapLocationEvent {
  final Position position;
  UpdateLocation({required this.position});
}

class StopLocation extends DriverMapLocationEvent {}

class AddMyPositionMarker extends DriverMapLocationEvent {
  final double lat;
  final double lng;
  AddMyPositionMarker({required this.lat, required this.lng});
}

class ConnectSocketIo extends DriverMapLocationEvent {}

class DisconnectSocketIo extends DriverMapLocationEvent {}

class EmitDriverPositionSoketIo extends DriverMapLocationEvent {}