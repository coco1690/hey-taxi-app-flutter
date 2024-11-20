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

class ChangeMapCameraPositionDestination extends ClientMapSeekerEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPositionDestination({required this.lat, required this.lng});
}

class OnCameraMove extends ClientMapSeekerEvent {
  final CameraPosition cameraPosition;
  OnCameraMove({required this.cameraPosition});
}

class OnCameraMoveDestination extends ClientMapSeekerEvent {
  final CameraPosition cameraPosition;
  OnCameraMoveDestination({required this.cameraPosition});
}

class OnCameraIdle extends ClientMapSeekerEvent  { }

class OnCameraIdleDestination extends ClientMapSeekerEvent  {
  //  final double lat;
  //  final double lng;
  //  final String destinationDescription;
  // OnCameraIdleDestination({required this.lat, required this.lng, required this.destinationDescription});
 }

class OnGoogleAutocompletepickUpSelected extends ClientMapSeekerEvent {
  final double lat;
  final double lng;
  final String pickUpDescription;
  OnGoogleAutocompletepickUpSelected({required this.lat, required this.lng, required this.pickUpDescription});
}
  
class OnGoogleAutocompleteDestinationSelected extends ClientMapSeekerEvent {
  final double lat;
  final double lng;
  final String destinationDescription;
  OnGoogleAutocompleteDestinationSelected({required this.lat, required this.lng, required this.destinationDescription});
}

