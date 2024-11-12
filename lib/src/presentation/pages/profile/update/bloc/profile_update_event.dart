import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';


abstract class ProfileUpdateEvent {}

class ProfileUpdateInitEvent extends ProfileUpdateEvent {
  final User? user;
  ProfileUpdateInitEvent({ required this.user });
}

class ProfileUpdateNameChanged     extends ProfileUpdateEvent {
  final BlocFormItem name;
  ProfileUpdateNameChanged({ required this.name});
}

class ProfileUpdatePhoneChanged    extends ProfileUpdateEvent {
  final BlocFormItem phone;
  ProfileUpdatePhoneChanged({ required this.phone});
}

class ProfileFormSubmitUpdate extends ProfileUpdateEvent {}

class UpdateUserSession extends ProfileUpdateEvent {
  final User user;
  UpdateUserSession({ required this.user});
} 

class PickImage extends ProfileUpdateEvent {}

class TakePhoto extends ProfileUpdateEvent {}