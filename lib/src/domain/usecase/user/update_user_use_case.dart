import 'dart:io';
import '../../models/user.dart';
import '../../repository/users_repository.dart';

class UpdateUserUseCase {

  UsersRepository repository;

  UpdateUserUseCase( this.repository);

  run( int id, User user, File? image)  => repository.update( id, user, image);

}