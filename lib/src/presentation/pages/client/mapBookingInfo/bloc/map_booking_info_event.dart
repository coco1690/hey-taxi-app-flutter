import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class ClientMapBookingInfoEvent {}

class ClientMapBookingInfoInitEvent extends ClientMapBookingInfoEvent{
  final LatLng pickUpPLatLng;
  final LatLng destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;

  ClientMapBookingInfoInitEvent({
    required this.pickUpPLatLng,
    required this.destinationLatLng,
    required this.pickUpDescription,
    required this.destinationDescription,
  });
}

class FindMyPositionMapBookingInfo extends ClientMapBookingInfoEvent {}

class ChangeMapCameraPositionMapBookingInfo extends ClientMapBookingInfoEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPositionMapBookingInfo({required this.lat, required this.lng});
}

class AddPolyline extends ClientMapBookingInfoEvent {}
  
class ToggleBottomSheetEvent extends ClientMapBookingInfoEvent{
  final bool isBottomSheetExpanded;
  ToggleBottomSheetEvent({required this.isBottomSheetExpanded});
}



