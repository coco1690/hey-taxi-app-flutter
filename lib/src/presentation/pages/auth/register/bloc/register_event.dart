import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';

abstract class RegisterEvent {}

class NameRegisterChanged extends RegisterEvent{
  final BlocFormItem name;
  NameRegisterChanged({ required this.name});
}

class PhoneRegisterChanged extends RegisterEvent{
  final BlocFormItem phone;
  PhoneRegisterChanged({ required this.phone});
}

class EmailRegisterChanged extends RegisterEvent{
  final BlocFormItem email;
  EmailRegisterChanged({ required this.email});
}

class PasswordRegisterChanged extends RegisterEvent{
  final BlocFormItem password;
  PasswordRegisterChanged({ required this.password});
}

class RegisterInitEvent extends RegisterEvent {}

class FormSubmitRegister extends RegisterEvent {}

class FormReset extends RegisterEvent{}

class SaveUserSession extends RegisterEvent {
  final AuthResponseModel authResponseModel;
  SaveUserSession({ required this.authResponseModel });
}