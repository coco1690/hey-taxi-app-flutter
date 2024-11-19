import 'package:google_maps_flutter/google_maps_flutter.dart';


abstract class ClientMapSeekerEvent {}

class ClientMapSeekerInitEvent extends ClientMapSeekerEvent{}
class FindMyPosition extends ClientMapSeekerEvent {}
class FindMyPositionSelectionMap extends ClientMapSeekerEvent {}
class ChangeMapCameraPosition extends ClientMapSeekerEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({required this.lat, required this.lng});
}

class OnCameraMove extends ClientMapSeekerEvent {
  final CameraPosition cameraPosition;
  OnCameraMove({required this.cameraPosition});
}

class OnCameraIdle extends ClientMapSeekerEvent  { }

