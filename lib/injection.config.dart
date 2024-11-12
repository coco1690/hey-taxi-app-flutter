// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hey_taxi_app/src/data/dataSource/local/sharef_pref.dart' as _i6;
import 'package:hey_taxi_app/src/data/dataSource/remote/service/auth_service.dart'
    as _i4;
import 'package:hey_taxi_app/src/data/dataSource/remote/service/users_service.dart'
    as _i9;
import 'package:hey_taxi_app/src/di/app_module.dart' as _i10;
import 'package:hey_taxi_app/src/domain/repository/auth_repository.dart' as _i3;
import 'package:hey_taxi_app/src/domain/repository/users_repository.dart'
    as _i8;
import 'package:hey_taxi_app/src/domain/usecase/auth/index.dart' as _i5;
import 'package:hey_taxi_app/src/domain/usecase/user/user_use_cases.dart'
    as _i7;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i4.AuthService>(() => appModule.authService);
    gh.factory<_i5.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i6.SharefPref>(() => appModule.sharefPref);
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i7.UserUseCases>(() => appModule.userUseCases);
    gh.factory<_i8.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i9.UsersService>(() => appModule.usersService);
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}
