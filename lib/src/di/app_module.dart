import 'package:hey_taxi_app/src/data/dataSource/local/sharef_pref.dart';
import 'package:hey_taxi_app/src/data/dataSource/remote/service/auth_service.dart';
import 'package:hey_taxi_app/src/data/dataSource/remote/service/users_service.dart';
import 'package:hey_taxi_app/src/data/repository/auth_repository_imple.dart';
import 'package:hey_taxi_app/src/data/repository/users_repository_imple.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/repository/auth_repository.dart';
import 'package:hey_taxi_app/src/domain/repository/users_repository.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/logout_use_case.dart';
import 'package:hey_taxi_app/src/domain/usecase/user/update_user_use_case.dart';
import 'package:hey_taxi_app/src/domain/usecase/user/user_use_cases.dart';
import 'package:injectable/injectable.dart';
import '../domain/usecase/auth/index.dart';

@module
abstract class AppModule{

  @injectable
  SharefPref get sharefPref  => SharefPref();

  @injectable
  Future<String> get token async {
    String token = '';
    final userSession = await sharefPref.read('user');
      if (userSession != null) {
        AuthResponseModel authResponseModel = AuthResponseModel.fromJson(userSession);
        token = authResponseModel.token;
    }
      return token;
  }

  
  @injectable  
  AuthService get authService => AuthService();

  @injectable  
  UsersService get usersService => UsersService( token );

  @injectable  
  AuthRepository get authRepository => AuthRepositoryImpl(authService, sharefPref);

  @injectable  
  UsersRepository get usersRepository => UsersRepositoryImple(usersService);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(

    login:            LoginUseCase            (authRepository), 
    register:         RegisterUsecase         (authRepository),
    saveUserSession:  SaveUserSessionUseCase  (authRepository),
    getUserSession:   GetUserSessionUseCase   (authRepository),
    logout:           LogoutUseCase           (authRepository)
    
    );

    @injectable
    UserUseCases get userUseCases => UserUseCases(  
      updateUser:      UpdateUserUseCase      (usersRepository)
    );
}