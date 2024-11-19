import 'dart:convert';
import 'package:hey_taxi_app/src/data/api/api_config.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/utils/list_to_string.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;

class AuthService {
  
   Future<Resource> login( String email, String password) async {
    try{
      
      Uri url = Uri.http( ApiConfig.API_HEY_TAXI, '/api/v1/auth/login');
      Map< String, String > headers = { 'Content-Type': 'application/json'};
      String body = json.encode({
        'email': email,
        'password': password
      });
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      print('Data recibida: $data');

      if( response.statusCode == 200 || response.statusCode == 201 ){

         AuthResponseModel authResponseModel = AuthResponseModel.fromJson(data); // transformo la Data a authResponse
         
         print( ' Data Remote Login: ${ authResponseModel.toJson()}');
         print( ' Token Auth Service login: ${ authResponseModel.token}');


         return Succes( authResponseModel ); // viene de utils resource

      } else {
         return ErrorData( listToString(data['message']) );
      }
     

    } catch(e){
      print('Error Auth Service Login: $e');

      return ErrorData( e.toString());// viene de utils resource
    }
   }

   Future<Resource> register( User user ) async {
    try{
      
      Uri url = Uri.http( ApiConfig.API_HEY_TAXI, '/api/v1/auth/register');
      Map< String, String > headers = { 'Content-Type': 'application/json'};
      String body = json.encode(<String, dynamic>{
        'name': user.name,
        'phone': user.phone,
        'email': user.email,
        'password': user.password,
        // 'isActive': user.isActive ?? '',
        // 'image': user.image ?? '',
        // 'notificationToken': user.notificationToken ?? '',
      });
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if( response.statusCode == 200 || response.statusCode == 201 ){
        
         
         AuthResponseModel authResponseModel = AuthResponseModel.fromJson(data); // transformo la Data a authResponseModel
         print( ' Data Remote Register: ${ authResponseModel.toJson()}');
         print( ' Token Auth Service register:       ${ authResponseModel.token}');


         return Succes( authResponseModel ); // viene de utils resource

      } else {
         return ErrorData( listToString(data['message']) );
      }
     

    } catch(e){
      print('Error en catch auth_service: $e');

      return ErrorData( e.toString());// viene de utils resource
    }
   }
}
