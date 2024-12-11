// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hey_taxi_app/src/data/dataSource/local/sharef_pref.dart'
    as _i61;
import 'package:hey_taxi_app/src/data/dataSource/remote/service/index.dart'
    as _i618;
import 'package:hey_taxi_app/src/di/app_module.dart' as _i422;
import 'package:hey_taxi_app/src/domain/repository/index.dart' as _i195;
import 'package:hey_taxi_app/src/domain/usecase/auth/index.dart' as _i1069;
import 'package:hey_taxi_app/src/domain/usecase/driver_position/index.dart'
    as _i108;
import 'package:hey_taxi_app/src/domain/usecase/geolocator/index.dart' as _i59;
import 'package:hey_taxi_app/src/domain/usecase/socket/socket_usecases.dart'
    as _i423;
import 'package:hey_taxi_app/src/domain/usecase/user/user_use_cases.dart'
    as _i464;
import 'package:injectable/injectable.dart' as _i526;
import 'package:socket_io_client/socket_io_client.dart' as _i414;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i61.SharefPref>(() => appModule.sharefPref);
    gh.factory<_i414.Socket>(() => appModule.socket);
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i618.AuthService>(() => appModule.authService);
    gh.factory<_i618.UsersService>(() => appModule.usersService);
    gh.factory<_i618.DriverPositionService>(
        () => appModule.driverPositionService);
    gh.factory<_i195.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i195.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i195.SocketRepository>(() => appModule.socketRepository);
    gh.factory<_i195.GeolocatorRepository>(
        () => appModule.geolocatorRepository);
    gh.factory<_i195.DriverPositionRepository>(
        () => appModule.driverPositionRepository);
    gh.factory<_i1069.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i464.UserUseCases>(() => appModule.userUseCases);
    gh.factory<_i59.GeolocatorUseCases>(() => appModule.geolocatorUseCases);
    gh.factory<_i423.SocketUseCases>(() => appModule.socketUseCases);
    gh.factory<_i108.DriverPositionUseCases>(
        () => appModule.driverPositionUseCases);
    return this;
  }
}

class _$AppModule extends _i422.AppModule {}
