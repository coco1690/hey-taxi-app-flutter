import 'package:hey_taxi_app/src/domain/usecase/driver_position/create_driver_position_usecase.dart';
import 'package:hey_taxi_app/src/domain/usecase/driver_position/delete_driver_position_usecase.dart';

class DriverPositionUseCases {

  CreateDriverPositionUseCase createDriverPosition;
  DeleteDriverPositionUseCase deleteDriverPosition;

  DriverPositionUseCases({
    required this.createDriverPosition,
    required this.deleteDriverPosition,
  });
}