import 'package:hey_taxi_app/src/domain/models/client_request.dart';
import 'package:hey_taxi_app/src/domain/models/client_request_response.dart';
import 'package:hey_taxi_app/src/domain/models/time_and_distance_values.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';


abstract class ClientRequestRepository {

  //OBTNER DISTANCIA Y TIEMPO DESDE CLIENTE
  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequest(

    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
    int recommendedValue
    
    );

    //CREO SOLICITUD DE VIAJE DESDE CLIENTE
    Future<Resource<int>> create( ClientRequest clientRequest);

    //ACTUALIZO LA RESPUESTA DEL CLIENTE Y ASIGNO IN DRIVER Y STATUS ACCEPTED
    Future<Resource<bool>> updateDriverAssigned( 
      int idClientRequest,
      int idDriverAssigned,
      int fareAccepted
    );


    //OBTENER SOLICITUD DE VIAJE DE LOS CLIENTES
    Future<Resource<List<ClientRequestResponse>>> getNearbyTripRequest(

    double driverLat,
    double driverlng,
   
    
    );



}