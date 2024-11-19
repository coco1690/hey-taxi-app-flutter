import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/injection.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/auth_use_cases.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart';
import 'package:hey_taxi_app/src/domain/usecase/user/user_use_cases.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/login/bloc/login_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/login/bloc/login_event.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/home/bloc/index.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker.bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/profile/info/bloc/index.dart';
import 'package:hey_taxi_app/src/presentation/pages/profile/update/bloc/index.dart';
import 'src/presentation/pages/auth/register/bloc/register_bloc.dart';
import 'src/presentation/pages/auth/register/bloc/register_event.dart';




List<BlocProvider> blocProvider = [

  BlocProvider<LoginBloc>           (create: (context) => LoginBloc           ( locator<AuthUseCases>())..add(LoginInitEvent())),
  BlocProvider<RegisterBloc>        (create: (context) => RegisterBloc        ( locator<AuthUseCases>())..add(RegisterInitEvent())),
  BlocProvider<ClientHomeBloc>      (create: (context) => ClientHomeBloc      ( locator<AuthUseCases>())..add(GetUserInfoHome())),
  BlocProvider<ProfileInfoBloc>     (create: (context) => ProfileInfoBloc     ( locator<AuthUseCases>())..add(GetUserInfo())),
  BlocProvider<ProfileUpdateBloc>   (create: (context) => ProfileUpdateBloc   ( locator<UserUseCases>(), locator<AuthUseCases>())),
  BlocProvider<ClientMapSeekerBloc> (create: (context) => ClientMapSeekerBloc ( locator<GeolocatorUseCases>())),


];