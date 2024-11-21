import 'package:google_maps_flutter/google_maps_flutter.dart';


abstract class ClientDestinationMapEvent {}

class ClientDestinationMapInitEvent extends ClientDestinationMapEvent{}
class FindMyPositionDestinationMap extends ClientDestinationMapEvent {}

class ChangeMapCameraPositionDestination extends ClientDestinationMapEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPositionDestination({required this.lat, required this.lng});
}

class OnCameraMoveDestination extends ClientDestinationMapEvent {
  final CameraPosition cameraPosition;
  OnCameraMoveDestination({required this.cameraPosition});
}

class OnCameraIdleDestination extends ClientDestinationMapEvent  {
  //  final double lat;
  //  final double lng;
  //  final String destinationDescription;
  // OnCameraIdleDestination({required this.lat, required this.lng, required this.destinationDescription});
 }

class OnGoogleAutocompletepickUpSelectedDestination extends ClientDestinationMapEvent {
  final double lat;
  final double lng;
  final String pickUpDescription;
  OnGoogleAutocompletepickUpSelectedDestination({required this.lat, required this.lng, required this.pickUpDescription});
}
  
class OnGoogleAutocompleteSelectedDestinationMap extends ClientDestinationMapEvent {
  final double lat;
  final double lng;
  final String destinationDescription;
  OnGoogleAutocompleteSelectedDestinationMap({required this.lat, required this.lng, required this.destinationDescription});
}


