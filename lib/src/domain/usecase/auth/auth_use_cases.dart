

import 'package:hey_taxi_app/src/domain/usecase/auth/logout_use_case.dart';

import 'index.dart';

class AuthUseCases {

  LoginUseCase           login;
  RegisterUsecase        register;
  SaveUserSessionUseCase saveUserSession;
  GetUserSessionUseCase  getUserSession;
  LogoutUseCase          logout;

  AuthUseCases({
    required this.login,
    required this.register,
    required this.saveUserSession,
    required this.getUserSession,
    required this.logout,
  });
}