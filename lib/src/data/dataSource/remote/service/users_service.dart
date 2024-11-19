import 'dart:convert';
import 'dart:io';
import 'package:hey_taxi_app/src/data/api/api_config.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/utils/list_to_string.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class UsersService {

    Future<String> token;
    UsersService( this.token);

    Future<Resource> update( int id, User user ) async {
      try{
        Uri url = Uri.http( ApiConfig.API_HEY_TAXI, '/api/v1/users/$id');
        Map< String, String > headers = { 
          'Content-Type': 'application/json',
          'Authorization': await token
          };
        String body = json.encode({
        'name':  user.name,
        'phone': user.phone
      });
      
        final response = await http.put(url, headers: headers, body: body);
        final data = json.decode(response.body);
        print('Data recibida desde users_service update: $data');

        if( response.statusCode == 200 || response.statusCode == 201 ){
         User userResponse = User.fromJson(data); // transformo la Data a authResponse
         return Succes( userResponse ); // viene de utils resource

      } else {
         return ErrorData( listToString(data['message']) );
      }

      } catch(e){
        print('Error en catch users_service: $e');
        return ErrorData( e.toString());// viene de utils resource
      }
  }

    Future<Resource> updateImage(int id, User user, File file) async { 
    try {
      Uri url = Uri.http(ApiConfig.API_HEY_TAXI, '/api/v1/users/upload/$id');
      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = await token;
      request.files.add(http.MultipartFile(
        'file',
        http.ByteStream(file.openRead().cast()),
        await file.length(),
        filename: basename(file.path),
        contentType: MediaType('image', 'jpg')
      ));
      request.fields['name'] = user.name;
      request.fields['phone'] = user.phone;
      final response = await request.send();
      final data = json.decode(await response.stream.transform(utf8.decoder).first);
      if (response.statusCode == 200 || response.statusCode == 201) {
        User userResponse = User.fromJson(data);
        return Succes(userResponse);
      }
      else {
         return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error in UsersService updateImage: $e');
      return ErrorData(e.toString());
    }
  }
}