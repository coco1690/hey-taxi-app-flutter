

import 'dart:convert';

import 'package:hey_taxi_app/src/data/api/api_config.dart';
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
      print('Error en catch auth_service: $e');

      return ErrorData( e.toString());// viene de utils resource
    }
  }
}


