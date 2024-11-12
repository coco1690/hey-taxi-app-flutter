import 'dart:io';
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';

abstract class UsersRepository {

  Future<Resource> update( int id, User user, File? image);

}