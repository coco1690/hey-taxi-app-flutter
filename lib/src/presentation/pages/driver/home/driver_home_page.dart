import 'package:flutter/material.dart';
import 'package:hey_taxi_app/bloc_socketIo/index.dart';
import 'package:hey_taxi_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:hey_taxi_app/src/domain/models/role.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/presentation/pages/driver/mapLocation/bloc/index.dart';

import 'package:hey_taxi_app/src/presentation/pages/driver/mapLocation/driver_map_location_page.dart';
import '../../index.dart';
import '../driver_client_requests/driver_client_requests_page.dart';
import 'bloc/index.dart';


class DriverHomePage extends StatefulWidget {

  
 const DriverHomePage( {super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  
late DriverHomeBloc _bloc;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

 @override
  void initState() {
    _bloc = context.read<DriverHomeBloc>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc.add(ChangeDrawerDriverPage(pageIdex: 0));
    });
      // context.read<DriverMapLocationBloc>().add(DriverMapLocationInitEvent());
    super.initState();

 }

  List<Widget> pageList = <Widget>[
    const DriverMapLocationPage(),
    const DriverClientRequestsPage(),    
    const ProfileInfoPage(),    
    const RolesPage()
    ];
  
 
  @override
  Widget build(BuildContext context) {
   final Role? role = ModalRoute.of(context)?.settings.arguments as Role?;
   final DriverHomeBloc driverHomeBloc = context.read<DriverHomeBloc>();

    return Scaffold(
      key: _scaffoldKey,
      body: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          return Stack(
            children: [

            pageList[ state.pageIdex ],
             Positioned(
                  top: 60,
                  left: 5,
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    color: const Color.fromARGB(255, 230, 254, 83),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                ),
            ]
         );
        },
      ),
      drawer: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
            final User? user = state.user;
            //  print('usuario client home page: $user');
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 19, 19, 19),
                          Color.fromARGB(255, 18, 18, 18),
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: _imageLisTitleUser(context, state, driverHomeBloc, user, role )
                )              
              ),

                ListTile(
                  title: const Text('Mapa de localizacion'),
                  selected: state.pageIdex == 0, 
                  // agg el primer valor
                  onTap: ()  {
                    context.read<DriverHomeBloc>().add(ChangeDrawerDriverPage( pageIdex: 0 ) ); // en el .add agregpo los eventos
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Solicitudes de viajes'),
                  selected: state.pageIdex == 1, 
                  // agg el primer valor
                  onTap: ()  {
                    context.read<DriverHomeBloc>().add(ChangeDrawerDriverPage( pageIdex: 1) ); // en el .add agregpo los eventos
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  title: const Text('Roles de usuario'),
                  selected: state.pageIdex == 3, 
                  onTap: () {
                    // 1. Desconexión
                    // context.read<DriverMapLocationBloc>().add(StopLocation());
                    // context.read<DriverMapLocationBloc>().add(DisconnectSocketIo());
                    // print('DRIVER DESCONECTADO');
                    
                    // 2. Cambiar rol
                    // context.read<AuthUseCases>().setRole('client');
                     context.read<DriverHomeBloc>().add(ChangeDrawerDriverPage( pageIdex: 3 ) );
                    // 3. Ir a pantalla de cliente
                   Navigator.pop(context);
                  },
                ),

              
                ListTile(
                  title: const Text('Cerrar sesion'),
                  onTap: () {
                     // 1. Desconexión
                    context.read<DriverHomeBloc>().add(Logout() ); // en el .add agregpo los eventos
                    context.read<DriverMapLocationBloc>().add(StopLocation());
                    context.read<BlocSocketIO>().add(DisconnectSocketIo());
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (context) => const MyApp() ), 
                      (route) => false);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


  Widget _imageLisTitleUser(
  BuildContext context, DriverHomeState state, DriverHomeBloc driverHomeBloc, User? user, Role? role) {
  return Column(
    children: [
      ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
            child: user != null && user.image != null
                ? CachedNetworkImage(
                    imageUrl: user.image!,
                    placeholder: (context, url) => Image.asset('assets/img/user_image.png'),
                    errorWidget: (context, url, error) => Image.asset('assets/img/user_image.png'),
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/img/user_image.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        title: Text(
          user?.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text( 
          role?.id ?? 'CONDUCTOR',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color.fromARGB(255, 172, 234, 3)),
         ),
        selected: state.pageIdex == 2, // agg el primer valor
        onTap: () {
          driverHomeBloc.add(ChangeDrawerDriverPage(pageIdex: 2)); // en el .add agregpo los eventos
          Navigator.pop(context);
        },
      )
    ],
  );
}






