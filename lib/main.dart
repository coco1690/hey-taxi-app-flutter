import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/bloc_providers.dart';
import 'package:hey_taxi_app/injection.dart';
import 'src/presentation/pages/client/mapSeeker/client_selection_map_page.dart';
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
          'login':                (BuildContext context) => const LoginPage(),
          'register':             (BuildContext context) => const RegisterPage(),
          'client/home':          (BuildContext context) => const ClientHomePage(),
          'profile/update':       (BuildContext context) => const ProfileUpdatePage(),
          'client/selectionmap':  (BuildContext context) => const ClientSelectionMapPage(),
        },
      ),
    );
  }
}
