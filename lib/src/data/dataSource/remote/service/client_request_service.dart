

import 'dart:convert';

import 'package:hey_taxi_app/src/data/api/api_config.dart';
import 'package:hey_taxi_app/src/domain/models/client_request.dart';
import 'package:hey_taxi_app/src/domain/models/client_request_response.dart';
import 'package:hey_taxi_app/src/domain/models/time_and_distance_values.dart';
import 'package:hey_taxi_app/src/domain/utils/list_to_string.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;

class ClientRequestService {

  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequest(double originLat, double originLng, double destinationLat, double destinationLng) async {
    
     try{  
      Uri url = Uri.http( ApiConfig.API_HEY_TAXI, '/api/v1/client-requests/$originLat/$originLng/$destinationLat/$destinationLng');
      Map< String, String > headers = { 'Content-Type': 'application/json'};
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);

      if( response.statusCode == 200 || response.statusCode == 201 ){
        TimeAndDistanceValues timeAndDistanceValues = TimeAndDistanceValues.fromJson(data); // transformo la Data a timeAndDistanceValues
         return Succes( timeAndDistanceValues ); // viene de utils resource

      } else {
         return ErrorData( listToString(data['message']) );
      }
     

    } catch(e){
      print('Error en catch ClientRequestService getTimeAndDistanceClientRequest : $e');

      return ErrorData( e.toString());// viene de utils resource
    }
  }


  Future<Resource<bool>> create(ClientRequest clientRequest) async {
    try{  
      Uri url = Uri.http( ApiConfig.API_HEY_TAXI, '/api/v1/client-requests');
      Map< String, String > headers = { 'Content-Type': 'application/json'};
      String body = json.encode(clientRequest);
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      print('Data recibida: $data');

      if( response.statusCode == 200 || response.statusCode == 201 ){
        //  ClientRequest clientRequest = ClientRequest.fromJson(data); // transformo la Data a authResponse 
         print( ' Data Remote ClientRequest create: ${ clientRequest.toJson()}');
         return Succes( true ); // viene de utils resource

      } else {
         return ErrorData( listToString(data['message']) );
      }
     
    } catch(e){
      print('Error en client request service Create: $e');
      return ErrorData( e.toString());// viene de utils resource
    }

  }


  //OBTENER SOLICITUD DE VIAJE DE LOS CLIENTES
  Future<Resource<List<ClientRequestResponse>>> getNearbyTripRequest(double driverLat, double driverLng) async {
    
     try{  
      Uri url = Uri.http( ApiConfig.API_HEY_TAXI, '/api/v1/client-requests/$driverLat/$driverLng');
      Map< String, String > headers = { 'Content-Type': 'application/json'};
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);

      if( response.statusCode == 200 || response.statusCode == 201 ){
        
        // EL FROMJSONLIST SE CONFIGUARA PARA TRANSFORMAR LA LISTA DE CLIENTSREQUESTRESPONSE EN EL MODEL
        List<ClientRequestResponse> listClientRequestResponses = ClientRequestResponse.fromJsonList(data); // LISTA DE CLIENTSREQUESTRESPONSE SE TRANSFORMA EN EL MODEL
         return Succes( listClientRequestResponses); // viene de utils resource

      } else {
         return ErrorData( listToString(data['message']) );
      }
     

    } catch(e){
      print('Error en catch ClientRequestService getNearbyTripRequest: $e');

      return ErrorData( e.toString());// viene de utils resource
    }
  }
}



