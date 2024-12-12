import 'package:hey_taxi_app/src/data/dataSource/remote/service/client_request_service.dart';
import 'package:hey_taxi_app/src/data/repository/client_request_repository_imple.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:hey_taxi_app/src/data/api/api_config.dart';
import 'package:hey_taxi_app/src/data/dataSource/local/sharef_pref.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/logout_use_case.dart';
import 'package:hey_taxi_app/src/domain/usecase/socket/connect_socket_usecase.dart';
import 'package:hey_taxi_app/src/domain/usecase/socket/disconnect_socket_usecase.dart';
import 'package:hey_taxi_app/src/domain/usecase/socket/socket_usecases.dart';
import 'package:hey_taxi_app/src/domain/usecase/user/update_user_use_case.dart';
import 'package:hey_taxi_app/src/domain/usecase/user/user_use_cases.dart';

import '../data/dataSource/remote/service/index.dart';
import '../data/repository/index.dart';
import '../domain/repository/index.dart';
import '../domain/usecase/auth/index.dart';
import '../domain/usecase/client-request/index.dart';
import '../domain/usecase/driver_position/index.dart';
import '../domain/usecase/geolocator/index.dart';

@module
abstract class AppModule{

  @injectable
  SharefPref get sharefPref  => SharefPref();

  @injectable
  Socket get socket => io('http://${ApiConfig.API_HEY_TAXI}', 
  OptionBuilder()
    .setTransports(['websocket']) // for Flutter or Dart VM
    .disableAutoConnect()  // disable auto-connection
    .build()
  );
  
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





  // ############## INSTANCIA DE SERVICE  ###############

  @injectable  
  AuthService get authService => AuthService();

  @injectable  
  UsersService get usersService => UsersService( token );

  @injectable
  DriverPositionService get driverPositionService => DriverPositionService();

  @injectable
  ClientRequestService get clientRequestService => ClientRequestService();




  // ############## INSTANCIA DE REPOSITORIOS ##############

  @injectable  
  AuthRepository get authRepository => AuthRepositoryImpl(authService, sharefPref);

  @injectable  
  UsersRepository get usersRepository => UsersRepositoryImple(usersService);

  @injectable
  SocketRepository get socketRepository => SocketRepositoryImpl( socket);

  @injectable  
  GeolocatorRepository get geolocatorRepository => GeolocatorRepositoryImpl();

  @injectable
  DriverPositionRepository get driverPositionRepository => DriverPositionRepositoryImple( driverPositionService );

  @injectable
  ClientRequestRepository get clientRequestRepository => ClientRequestRepositoryImple( clientRequestService );




  // ############## INSTANCIA DE USECASES ##############

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

    @injectable
    GeolocatorUseCases get geolocatorUseCases => GeolocatorUseCases(
      findMyPosition:    FindMyPositionUseCase      (geolocatorRepository),
      createMarker:      CreateMarkerUseCase        (geolocatorRepository),
      getMarker:         GetMarkerUseCase           (geolocatorRepository),
      getPlacemarkData:  GetPlacemarkDataUsecase    (geolocatorRepository),
      getPolyline:       GetPolylineUseCase         (geolocatorRepository),
      getPositionStream: GetPositionStreamUseCase   (geolocatorRepository)
    );

    @injectable
    SocketUseCases get socketUseCases => SocketUseCases(
      connect:          ConnectSocketUseCase        (socketRepository),
      disconnect:       DisconnectSocketUsecase     (socketRepository)
    );

    @injectable
    DriverPositionUseCases get driverPositionUseCases => DriverPositionUseCases(
      createDriverPosition: CreateDriverPositionUseCase(driverPositionRepository),
      deleteDriverPosition: DeleteDriverPositionUseCase(driverPositionRepository)
    );

    @injectable
    ClientRequestUseCases get clientRequestUseCases => ClientRequestUseCases(
      getTimeAndDistanceClientRequest: GetTimeAndDistanceClientRequestUseCase(clientRequestRepository)
    );
}