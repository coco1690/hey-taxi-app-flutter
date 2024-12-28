import 'dart:convert';

import 'package:hey_taxi_app/src/data/api/api_config.dart';
import 'package:hey_taxi_app/src/domain/models/driver_position.dart';
import 'package:hey_taxi_app/src/domain/utils/list_to_string.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;

class DriverPositionService {

  Future<Resource<bool>> create(DriverPosition driverPosition) async {

     try{  
      Uri url = Uri.http( ApiConfig.API_HEY_TAXI, '/api/v1/driver_position');
      Map< String, String > headers = { 'Content-Type': 'application/json'};
      String body = json.encode(driverPosition);
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if( response.statusCode == 200 || response.statusCode == 201 ){
         return Succes( true ); // viene de utils resource

      } else {
         return ErrorData( listToString(data['message']) );
      }
     

    } catch(e){
      print('Error en catch auth_service: $e');

      return ErrorData( e.toString());// viene de utils resource
    }
  }


  Future<Resource<DriverPosition>> getDriverPosition(int idDriver) async {

     try{  
      Uri url = Uri.http( ApiConfig.API_HEY_TAXI, '/api/v1/driver_position/$idDriver');
      Map< String, String > headers = { 'Content-Type': 'application/json'};
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);

      if( response.statusCode == 200 || response.statusCode == 201 ){
        DriverPosition driverPosition = DriverPosition.fromJson(data); // transformo la Data a authResponse
         return Succes(driverPosition); // viene de utils resource
         

      } else {
         return ErrorData( listToString(data['message']) );
      }
     

    } catch(e){
      print('Error en catch auth_service: $e');

      return ErrorData( e.toString());// viene de utils resource
    }
  }


  Future<Resource<bool>> delete( int idDriver ) async {

     try{  
      Uri url = Uri.http( ApiConfig.API_HEY_TAXI, '/api/v1/driver_position/$idDriver');
      Map< String, String > headers = { 'Content-Type': 'application/json'};
      final response = await http.delete(url, headers: headers);
      final data = json.decode(response.body);

      if( response.statusCode == 200 || response.statusCode == 201 ){
         return Succes( true ); // viene de utils resource

      } else {
         return ErrorData( listToString(data['message']) );
      }
     

    } catch(e){
      print('Error en catch auth_service: $e');

      return ErrorData( e.toString());// viene de utils resource
    }
  }
  
}