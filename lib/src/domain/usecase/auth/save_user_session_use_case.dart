import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/repository/auth_repository.dart';

class SaveUserSessionUseCase {

   AuthRepository repository; // inyectamos el repositorio

   SaveUserSessionUseCase( this.repository); // creamos el constructor
   
   run( AuthResponseModel authResponseModel)  => repository.saveUserSession(authResponseModel); // creamos el metodo run
}