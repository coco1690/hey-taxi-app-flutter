import 'dart:convert';
import 'package:hey_taxi_app/src/domain/models/driver_trip_request.dart';
import 'package:hey_taxi_app/src/domain/utils/list_to_string.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;

import 'package:hey_taxi_app/src/data/api/api_config.dart';

 class DriverTripRequestService {

    Future<Resource<DriverTripRequest>> create( DriverTripRequest driverTripRequest ) async {
        try{
          
          Uri url = Uri.http( ApiConfig.API_HEY_TAXI, '/api/v1/driver-trip-offers');
          Map< String, String > headers = { 'Content-Type': 'application/json'};
          String body = json.encode(driverTripRequest);
          final response = await http.post(url, headers: headers, body: body);
          final data = json.decode(response.body);

          if( response.statusCode == 200 || response.statusCode == 201 ){    
            DriverTripRequest driverTripRequest = DriverTripRequest.fromJson(data); 
            return Succes( driverTripRequest ); // viene de utils resource

          } else {
            return ErrorData( listToString(data['message']) );
          }
        

        } catch(e){
          print('Error en catch trip_request_service: $e');

          return ErrorData( e.toString());// viene de utils resource
        }
      }
 }