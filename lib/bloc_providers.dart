import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/bloc_socketIo/bloc_socketio_bloc.dart';
import 'package:hey_taxi_app/injection.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/auth_use_cases.dart';
import 'package:hey_taxi_app/src/domain/usecase/driver_position/index.dart';
import 'package:hey_taxi_app/src/domain/usecase/geolocator/geolocator_usecases.dart';
import 'package:hey_taxi_app/src/domain/usecase/user/user_use_cases.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeekerDestination/bloc/client_destination_map_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/driver/driver_client_requests/bloc/driver_client_requests_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/driver/mapLocation/bloc/driver_map_location_bloc.dart';
import 'src/domain/usecase/client-request/index.dart';
import 'src/domain/usecase/socket/index.dart';
import 'src/presentation/pages/auth/login/bloc/index.dart';
import 'src/presentation/pages/auth/register/bloc/index.dart';
import 'src/presentation/pages/client/home/bloc/index.dart';
import 'src/presentation/pages/client/mapBookingInfo/bloc/index.dart';
import 'src/presentation/pages/client/mapSeeker/bloc/index.dart';
import 'src/presentation/pages/driver/home/bloc/index.dart';
import 'src/presentation/pages/profile/info/bloc/index.dart';
import 'src/presentation/pages/profile/update/bloc/index.dart';
import 'src/presentation/pages/roles/bloc/index.dart';




List<BlocProvider> blocProvider = [

  BlocProvider<LoginBloc>                (create: (context) => LoginBloc                ( locator<AuthUseCases>())..add(LoginInitEvent())),
  BlocProvider<RegisterBloc>             (create: (context) => RegisterBloc             ( locator<AuthUseCases>())..add(RegisterInitEvent())),
  BlocProvider<ClientHomeBloc>           (create: (context) => ClientHomeBloc           ( locator<AuthUseCases>())..add(GetUserInfoHome())),
  BlocProvider<DriverHomeBloc>           (create: (context) => DriverHomeBloc           (locator<AuthUseCases>(),locator<DriverPositionUseCases>())..add(GetUserInfoDriverHome())),
  BlocProvider<RolesBloc>                (create: (context) => RolesBloc                ( locator<AuthUseCases>())..add(GetRolesList())),
  BlocProvider<ProfileInfoBloc>          (create: (context) => ProfileInfoBloc          ( locator<AuthUseCases>())..add(GetUserInfo())),
  BlocProvider<ProfileUpdateBloc>        (create: (context) => ProfileUpdateBloc        ( locator<UserUseCases>(), locator<AuthUseCases>())),
  BlocProvider<ClientDestinationMapBloc> (create: (context) => ClientDestinationMapBloc ( locator<GeolocatorUseCases>())),
  BlocProvider<ClientMapBookingInfoBloc> (create: (context) => ClientMapBookingInfoBloc ( locator<GeolocatorUseCases>(), locator<ClientRequestUseCases>(), locator<AuthUseCases>())),
  BlocProvider<DriverClientRequestsBloc> (create: (context) => DriverClientRequestsBloc ( locator<ClientRequestUseCases>(), locator<DriverPositionUseCases>(), locator<AuthUseCases>())),
  BlocProvider<BlocSocketIO>             (create: (context) => BlocSocketIO             ( locator<SocketUseCases>())), 
  BlocProvider<DriverMapLocationBloc>    (create: (context) => DriverMapLocationBloc    ( locator<GeolocatorUseCases>(),context.read<BlocSocketIO>(), locator<SocketUseCases>(), locator<AuthUseCases>(), locator<DriverPositionUseCases>())),
  BlocProvider<ClientMapSeekerBloc>      (create: (context) => ClientMapSeekerBloc      ( locator<GeolocatorUseCases>(),context.read<BlocSocketIO>(), locator<SocketUseCases>())),


];