import 'package:hey_taxi_app/src/domain/usecase/driver_position/create_driver_position_usecase.dart';
import 'package:hey_taxi_app/src/domain/usecase/driver_position/delete_driver_position_usecase.dart';

import 'get_driver_position_usecase.dart';

class DriverPositionUseCases {

  GetDriverPositionUseCase getDriverPosition;
  CreateDriverPositionUseCase createDriverPosition;
  DeleteDriverPositionUseCase deleteDriverPosition;

  DriverPositionUseCases({
    required this.getDriverPosition,
    required this.createDriverPosition,
    required this.deleteDriverPosition,
  });
}