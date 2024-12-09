import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/placemark_data.dart';


abstract class GeolocatorRepository {
  Future<Position> findMyPosition();
  
  Future<BitmapDescriptor> createMarkerFromAsset(String path, double width, double height);
  Marker getMarker(
    String markerId,
    double lat,
    double lng,
    BitmapDescriptor imageMarker,
    String title,
    String content,
  );

  Future<PlacemarkData?> getPlacemarkData( CameraPosition cameraPosition );

  Future<List<LatLng>> getPolyline( LatLng pickUpPLatLng, LatLng destinationLatLng );

  Stream<Position> getPositionStream();
}