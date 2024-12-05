import 'package:google_maps_flutter/google_maps_flutter.dart';


abstract class DriverMapLocationEvent {}

class DriverMapLocationInitEvent extends DriverMapLocationEvent {}
class FindMyPosition extends DriverMapLocationEvent {}
class FindMyPositionSelectionMap extends DriverMapLocationEvent {}

class ChangeMapCameraPosition extends DriverMapLocationEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({required this.lat, required this.lng});
}
class OnCameraMove extends DriverMapLocationEvent {
  final CameraPosition cameraPosition;
  OnCameraMove({required this.cameraPosition});
}


class OnUpdateStatedestinatio extends DriverMapLocationEvent {
  final bool isUpdateStatedestinatio;
  OnUpdateStatedestinatio({required this.isUpdateStatedestinatio});
}

