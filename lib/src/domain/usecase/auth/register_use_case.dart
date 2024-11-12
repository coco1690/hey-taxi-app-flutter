
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/repository/auth_repository.dart';

class RegisterUsecase {
   AuthRepository repository;

   RegisterUsecase( this.repository);
   
   run( User user)  => repository.register(user);

}