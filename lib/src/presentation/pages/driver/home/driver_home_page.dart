import 'package:flutter/material.dart';
import 'package:hey_taxi_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:hey_taxi_app/src/domain/models/role.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';

import 'package:hey_taxi_app/src/presentation/pages/driver/mapLocation/driver_map_location_page.dart';
import '../../index.dart';
import 'bloc/index.dart';


class DriverHomePage extends StatefulWidget {

  
 const DriverHomePage( {super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {


  List<Widget> pageList = <Widget>[
    const DriverMapLocationPage(),
    const ProfileInfoPage(),
    const RolesPage()
    ];
  
 
  @override
  Widget build(BuildContext context) {
   final Role? role = ModalRoute.of(context)?.settings.arguments as Role?;
   final DriverHomeBloc driverHomeBloc = context.read<DriverHomeBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 243, 159, 90,),
        foregroundColor: const Color.fromARGB(255,	237,	227,	213,),
      ),
      body: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          return pageList[ state.pageIdex ];
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
                        Color.fromARGB(255, 243, 159, 90),
                        Color.fromARGB(255, 114, 62, 19),
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
                  title: const Text('Roles de usuario'),
                  selected: state.pageIdex == 2, 
                  // agg el primer valor
                  onTap: ()  {
                    context.read<DriverHomeBloc>().add(ChangeDrawerDriverPage( pageIdex: 2 ) ); // en el .add agregpo los eventos
                    Navigator.pop(context);
                  },
                ),
              
                ListTile(
                  title: const Text('Cerrar sesion'),
                  onTap: () {
                    context.read<DriverHomeBloc>().add(Logout() ); // en el .add agregpo los eventos
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color.fromARGB(255, 210, 234, 52)),
         ),
        selected: state.pageIdex == 1, // agg el primer valor
        onTap: () {
          driverHomeBloc.add(ChangeDrawerDriverPage(pageIdex: 1)); // en el .add agregpo los eventos
          Navigator.pop(context);
        },
      )
    ],
  );
}





//   Widget _imageLisTitleUser( BuildContext context,  ClientHomeState state, ClientHomeBloc clientHomeBloc, User? user ){
 
//   return Column(
//     children: [                    
//       ListTile( 
//         leading:AspectRatio(
//           aspectRatio: 1,
//           child: ClipOval(
//             child: user != null && user.image != null
//           ? FadeInImage.assetNetwork(
//             placeholder: 'assets/img/user_image.png', 
//             image: user.image!,
//             fit: BoxFit.cover,
//             fadeInDuration: const Duration(seconds: 1),                       
//         ) 
//           : Image.asset(
//             'assets/img/user_image.png',
//             fit: BoxFit.cover,
//         ),
//       ),
//     ),
//       title: Text( user?.name ?? '', style: const TextStyle( fontWeight: FontWeight.bold, color: Colors.white),),
//       selected: state.pageIdex == 1, // agg el primer valor
//       onTap: () {
//         clientHomeBloc.add(ChangeDrawerPage( pageIdex: 1 ) ); // en el .add agregpo los eventos
//         Navigator.pop(context);
//       },
//      )
//    ],
//   );
// }





