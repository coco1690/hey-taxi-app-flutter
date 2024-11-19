import 'package:hey_taxi_app/src/domain/repository/auth_repository.dart';

class GetUserSessionUseCase {

   AuthRepository repository; // inyectamos el repositorio

   GetUserSessionUseCase( this.repository); // creamos el constructor
   
   run( )  => repository.getUserSession(); // creamos el metodo run
}