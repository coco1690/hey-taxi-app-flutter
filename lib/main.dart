import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/bloc_providers.dart';
import 'package:hey_taxi_app/injection.dart';
import 'src/presentation/pages/index.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: blocProvider,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, 
            // background:  Colors.blueGrey[800]
            ),
          useMaterial3: true,
        ),
        initialRoute: 'login',
        
        routes: {
          'login':                  (BuildContext context) => const LoginPage(),
          'register':               (BuildContext context) => const RegisterPage(),
          'roles':                  (BuildContext context) => const RolesPage(),
          'client/home':            (BuildContext context) => const ClientHomePage(),
          'driver/home':            (BuildContext context) => const DriverHomePage(),
          'profile/update':         (BuildContext context) => const ProfileUpdatePage(),
          'client/destinationmap':  (BuildContext context) => const ClientDestinationMapPage(),
          'client/map/booking':     (BuildContext context) => const MapBookingInfoPage(),
          // 'driver/maplocation':     (BuildContext context) => const DriverMapLocationPage(),
          // 'client/mapseeker':       (BuildContext context) => const ClientMapSeekerPage(),
          
        },
      ),
    );
  }
}
