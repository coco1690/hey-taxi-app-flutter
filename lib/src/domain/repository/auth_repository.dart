
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';

abstract class AuthRepository {

  Future<Resource<AuthResponseModel>> login( String email, String password);
  Future<Resource<AuthResponseModel>> register( User user);
  Future<void>                        saveUserSession( AuthResponseModel authResponse ); //metodo para almacenar la sesion
  Future<AuthResponseModel?>          getUserSession(); // metodo para obtener la sesion
  Future<bool>                        logout(); // metodo para cerrar sesion

}