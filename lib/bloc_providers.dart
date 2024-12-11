import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/injection.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/auth_use_cases.dart';
import 'package:hey_taxi_app/src/domain/usecase/driver_position/index.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart';
import 'package:hey_taxi_app/src/domain/usecase/user/user_use_cases.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/login/bloc/login_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/login/bloc/login_event.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/home/bloc/index.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeekerDestination/bloc/client_destination_map_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/driver/mapLocation/bloc/driver_map_location_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/profile/info/bloc/index.dart';
import 'package:hey_taxi_app/src/presentation/pages/profile/update/bloc/index.dart';
import 'package:hey_taxi_app/src/presentation/pages/roles/bloc/roles_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/roles/bloc/roles_event.dart';
import 'src/domain/usecase/socket/socket_usecases.dart';
import 'src/presentation/pages/auth/register/bloc/register_bloc.dart';
import 'src/presentation/pages/auth/register/bloc/register_event.dart';
import 'src/presentation/pages/client/mapBookingInfo/bloc/index.dart';
import 'src/presentation/pages/driver/home/bloc/index.dart';




List<BlocProvider> blocProvider = [

  BlocProvider<LoginBloc>                (create: (context) => LoginBloc                ( locator<AuthUseCases>())..add(LoginInitEvent())),
  BlocProvider<RegisterBloc>             (create: (context) => RegisterBloc             ( locator<AuthUseCases>())..add(RegisterInitEvent())),
  BlocProvider<ClientHomeBloc>           (create: (context) => ClientHomeBloc           ( locator<AuthUseCases>())..add(GetUserInfoHome())),
  BlocProvider<DriverHomeBloc>           (create: (context) => DriverHomeBloc           ( locator<AuthUseCases>())..add(GetUserInfoDriverHome())),
  BlocProvider<RolesBloc>                (create: (context) => RolesBloc                ( locator<AuthUseCases>())..add(GetRolesList())),
  BlocProvider<ProfileInfoBloc>          (create: (context) => ProfileInfoBloc          ( locator<AuthUseCases>())..add(GetUserInfo())),
  BlocProvider<ProfileUpdateBloc>        (create: (context) => ProfileUpdateBloc        ( locator<UserUseCases>(), locator<AuthUseCases>())),
  BlocProvider<ClientMapSeekerBloc>      (create: (context) => ClientMapSeekerBloc      ( locator<GeolocatorUseCases>(), locator<SocketUseCases>())),
  BlocProvider<DriverMapLocationBloc>    (create: (context) => DriverMapLocationBloc    ( locator<GeolocatorUseCases>(), locator<SocketUseCases>(), locator<AuthUseCases>(), locator<DriverPositionUseCases>())),
  BlocProvider<ClientDestinationMapBloc> (create: (context) => ClientDestinationMapBloc ( locator<GeolocatorUseCases>())),
  BlocProvider<ClientMapBookingInfoBloc> (create: (context) => ClientMapBookingInfoBloc ( locator<GeolocatorUseCases>())),


];