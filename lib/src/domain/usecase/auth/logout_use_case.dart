import 'package:hey_taxi_app/src/domain/repository/auth_repository.dart';

class LogoutUseCase {
   AuthRepository repository;

   LogoutUseCase( this.repository);
   
   run( )  => repository.logout();

}