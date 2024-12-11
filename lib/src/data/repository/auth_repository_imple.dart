import 'package:hey_taxi_app/src/data/dataSource/local/sharef_pref.dart';
import 'package:hey_taxi_app/src/data/dataSource/remote/service/auth_service.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/repository/auth_repository.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';

class AuthRepositoryImpl implements AuthRepository {

  AuthService authService; // dataSource remote
  SharefPref  sharefPref;  // dataSource local

  AuthRepositoryImpl( this.authService, this.sharefPref ); // Constructor
  

  // METODO PARA REALIZAR LOGIN 
  @override
  Future<Resource<AuthResponseModel>> login(String email, String password) async {
    return authService.login(email, password);
  }

  // METODO PARA REGISTAR UN USUARIO
  @override
  Future<Resource<AuthResponseModel>> register(User user) async {
    return authService.register(user);
  }

   // METODO PARA OBTENER DATOS DE SESION
  @override
  Future<AuthResponseModel?> getUserSession() async {
    final data = await sharefPref.read('user');
    if ( data != null ){
      AuthResponseModel authResponseModel = AuthResponseModel.fromJson( data );
        return authResponseModel;
    }
    return null;
  }

  // METODO PARA GUARDAR DATOS DE SESION
  @override
  Future<void> saveUserSession(AuthResponseModel authResponseModel) async{
    sharefPref.save('user', authResponseModel.toJson());
  }

   // METODO PARA CERRAR SESION
  @override
  Future<bool> logout() async{
    return await sharefPref.remove( 'user' );
  }




}