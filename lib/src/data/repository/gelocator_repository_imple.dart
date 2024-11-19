import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/repository/gelocator_repository.dart';

import '../../domain/models/placemark_data.dart';

class GeolocatorRepositoryImpl implements GeolocatorRepository {
  @override
  Future<Position> findMyPosition() async {

    bool serviceEnabled;
    LocationPermission permission;

  
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
      print('La Ubicación no está habilitada');
    return Future.error('Location services are disabled.');
  }

    permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Permiso no otorgado por el usuario');
      return Future.error('Location permissions are denied');
    }
  }
  
      if (permission == LocationPermission.deniedForever) {
         print('Permiso no otorgado por el usuario permanentemente');
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  } 

      return await Geolocator.getCurrentPosition();
    
  }

  @override
  Future<BitmapDescriptor> createMarkerFromAsset(String path) async {
    ImageConfiguration configuration = const ImageConfiguration();
    BitmapDescriptor descriptor = await BitmapDescriptor.asset(configuration, path,);
    return descriptor;

  }

  @override
  Marker getMarker(String markerId, double lat, double lng, BitmapDescriptor imageMarker, String title, String content) {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker (
      markerId: id,
      position: LatLng(lat, lng),
      icon: imageMarker,
      infoWindow: InfoWindow(title: title, snippet: content),
    );
    return marker;
  }

  @override
  Future<PlacemarkData?> getPlacemarkData( CameraPosition cameraPosition ) async {
    double lat = cameraPosition.target.latitude;
    double lng = cameraPosition.target.longitude;
    
    try { 
    List<Placemark> placemarkList = await placemarkFromCoordinates(lat, lng);

      if ( placemarkList.isNotEmpty ){
        String directions = placemarkList[0].thoroughfare ?? 'Desconocida';
        String street = placemarkList[0].subThoroughfare ?? 'calle no encontrada';
        String city = placemarkList[0].locality ?? 'Ciudad no encontrada';
        String departament = placemarkList[0].administrativeArea ?? 'Departamento no encontrado';
        PlacemarkData placemarkData = PlacemarkData( 
          address: '$directions, $street, $city, $departament',
          lat: lat,
          lng: lng,
      );
      return placemarkData;
    }
  } catch (e) { 
    print('Errro al obtener los datos de Placemark: $e');
  }
  
    return null;
}

}