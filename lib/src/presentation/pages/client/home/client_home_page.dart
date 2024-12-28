import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hey_taxi_app/main.dart';
import 'package:hey_taxi_app/src/domain/models/role.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';

import 'package:hey_taxi_app/src/presentation/pages/client/home/bloc/index.dart';
import '../../index.dart';
import '../mapSeeker/client_map_seeker_page.dart';

class ClientHomePage extends StatefulWidget {

  
 const ClientHomePage( {super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {

// late ClientHomeBloc _bloc;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//  @override
//   void initState() {
//     _bloc = context.read<ClientHomeBloc>();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       // _bloc.add(GetUserInfoHome());
//     _bloc.add(ChangeDrawerPage(pageIdex: 0));
//     });
//     super.initState();

//  }



  List<Widget> pageList = <Widget>[
    const ClientMapSeekerPage(),
    const ProfileInfoPage(),
    const RolesPage()
    ];
  

 
  @override
  Widget build(BuildContext context) {

   final Role? role = ModalRoute.of(context)?.settings.arguments as Role?;

   final ClientHomeBloc clientHomeBloc = context.read<ClientHomeBloc>();

    return Scaffold(
       key: _scaffoldKey,
      // appBar: AppBar(
      //   // backgroundColor:const Color.fromARGB(255, 243, 159, 90,),
      //   // backgroundColor:const Color.fromARGB(255, 192, 8, 8),
      //   // backgroundColor:const Color.fromARGB(255, 229, 244, 19),
      //   backgroundColor:const Color.fromARGB(251, 13, 13, 13),
      //   foregroundColor: const Color.fromARGB(255, 230, 254,83),
       
      // ),
      body: BlocBuilder<ClientHomeBloc, ClientHomeState>(
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
      drawer: BlocBuilder<ClientHomeBloc, ClientHomeState>(
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
                          // Color.fromARGB(255, 236, 12, 12),
                          // Color.fromARGB(255, 73, 6, 6),
                          // Color.fromARGB(255, 238, 255, 5),
                          // Color.fromARGB(255, 144, 154, 3),
                          Color.fromARGB(255, 19, 19, 19),
                          Color.fromARGB(255, 18, 18, 18),
                          // Color.fromARGB(255, 237, 245, 176),
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: _imageLisTitleUser(context, state, clientHomeBloc, user, role )
                )              
              ),

                ListTile(
                  title: const Text('Mapa de busqueda'),
                  selected: state.pageIdex == 0, 
                  // agg el primer valor
                  onTap: ()  {
                    context.read<ClientHomeBloc>().add(ChangeDrawerPage( pageIdex: 0 ) ); // en el .add agregpo los eventos
                    Navigator.pop(context);
                  },
                ),

                 ListTile(
                  title: const Text('Roles de usuario'),
                  selected: state.pageIdex == 2, 
                  // agg el primer valor
                  onTap: ()  {
                    context.read<ClientHomeBloc>().add(ChangeDrawerPage( pageIdex: 2 ) ); // en el .add agregpo los eventos
                    Navigator.pop(context);
                  },
                ),
              
                ListTile(
                  title: const Text('Cerrar sesion'),
                  onTap: () {
                    context.read<ClientHomeBloc>().add(Logout() ); // en el .add agregpo los eventos
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
  BuildContext context, ClientHomeState state, ClientHomeBloc clientHomeBloc, User? user, Role? role) {
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
          role?.id ?? 'CLIENTE',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color:  Color.fromARGB(255, 172, 234, 3)),
         ),
        selected: state.pageIdex == 1, // agg el primer valor
        onTap: () {
          clientHomeBloc.add(ChangeDrawerPage(pageIdex: 1)); // en el .add agregpo los eventos
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





//  Color.fromARGB(255, 243, 159, 90),
//                         Color.fromARGB(255, 114, 62, 19),