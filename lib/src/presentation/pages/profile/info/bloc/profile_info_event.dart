import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';

abstract class ProfileInfoEvent {}

class ProfileInfoUpdateInitEvent extends ProfileInfoEvent {
  final User? user;
  ProfileInfoUpdateInitEvent({ required this.user });
}

class ProfileInfoNameChanged     extends ProfileInfoEvent {
  final BlocFormItem name;
  ProfileInfoNameChanged({ required this.name});
}

class ProfileInfoPhoneChanged    extends ProfileInfoEvent {
  final BlocFormItem phone;
  ProfileInfoPhoneChanged({ required this.phone});
}

class ProfileInfoFormSubmitUpdate extends ProfileInfoEvent {}

class GetUserInfo                extends ProfileInfoEvent{}

