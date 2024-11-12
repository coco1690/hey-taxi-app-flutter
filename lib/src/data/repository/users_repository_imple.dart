import 'dart:io';

import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/repository/users_repository.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';

import '../dataSource/remote/service/users_service.dart';

class UsersRepositoryImple implements UsersRepository {
  
  UsersService usersService; // dataSource remote
  UsersRepositoryImple( this.usersService ); // Constructor

  @override
  Future<Resource> update(int id, User user, File? file) {
    if( file == null ){
      return usersService.update( id, user );
    }else{
      return usersService.updateImage( id, user, file );
    }
  }

}