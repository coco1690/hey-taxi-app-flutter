import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';

abstract class LoginEvent {}

class EmailChanged    extends LoginEvent{
  final BlocFormItem email;
  EmailChanged({ required this.email});
}

class PasswordChanged extends LoginEvent{
  final BlocFormItem password;
  PasswordChanged({ required this.password});
}

class LoginInitEvent  extends LoginEvent {}

class FormSubmit      extends LoginEvent {}

class SaveUserSession extends LoginEvent {
  final AuthResponseModel authResponseModel;
  SaveUserSession({ required this.authResponseModel });
}