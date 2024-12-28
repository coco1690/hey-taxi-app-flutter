 

 import 'package:hey_taxi_app/src/domain/models/driver_position.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';

abstract class DriverPositionRepository {

  Future<Resource<bool>> create(DriverPosition driverPosition);
  Future<Resource<bool>> delete(int idDriver);
  Future<Resource<DriverPosition>> getDriverPosition(int idDriver);
  
 }