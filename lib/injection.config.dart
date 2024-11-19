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
import 'package:hey_taxi_app/src/data/dataSource/remote/service/auth_service.dart'
    as _i465;
import 'package:hey_taxi_app/src/data/dataSource/remote/service/users_service.dart'
    as _i930;
import 'package:hey_taxi_app/src/di/app_module.dart' as _i422;
import 'package:hey_taxi_app/src/domain/repository/auth_repository.dart'
    as _i337;
import 'package:hey_taxi_app/src/domain/repository/gelocator_repository.dart'
    as _i546;
import 'package:hey_taxi_app/src/domain/repository/users_repository.dart'
    as _i935;
import 'package:hey_taxi_app/src/domain/usecase/auth/index.dart' as _i1069;
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart'
    as _i1069;
import 'package:hey_taxi_app/src/domain/usecase/user/user_use_cases.dart'
    as _i464;
import 'package:injectable/injectable.dart' as _i526;

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
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i465.AuthService>(() => appModule.authService);
    gh.factory<_i930.UsersService>(() => appModule.usersService);
    gh.factory<_i337.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i935.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i546.GeolocatorRepository>(
        () => appModule.geolocatorRepository);
    gh.factory<_i1069.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i464.UserUseCases>(() => appModule.userUseCases);
    gh.factory<_i1069.GeolocatorUseCases>(() => appModule.geolocatorUseCases);
    return this;
  }
}

class _$AppModule extends _i422.AppModule {}
