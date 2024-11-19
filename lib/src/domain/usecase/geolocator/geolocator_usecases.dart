import 'package:hey_taxi_app/src/domain/usecase/geolocator/create_marker_usecase.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/findmyposition_usecase.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/get_marker_usecase.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/get_placemark_data_usecase.dart';

class GeolocatorUseCases {
  
  FindMyPositionUseCase findMyPosition;
  CreateMarkerUseCase createMarker;
  GetMarkerUseCase getMarker;
  GetPlacemarkDataUsecase getPlacemarkData;
  
  GeolocatorUseCases({
    required this.findMyPosition,
    required this.createMarker,
    required this.getMarker,
    required this.getPlacemarkData,
  });
}