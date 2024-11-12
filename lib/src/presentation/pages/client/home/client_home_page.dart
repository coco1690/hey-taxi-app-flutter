import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/main.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';

import 'package:hey_taxi_app/src/presentation/pages/client/home/bloc/index.dart';
import '../../index.dart';

class ClientHomePage extends StatefulWidget {

  
 const ClientHomePage( {super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  List<Widget> pageList = <Widget>[const ProfileInfoPage()];
  
 
  @override
  Widget build(BuildContext context) {
 
   final ClientHomeBloc clientHomeBloc = context.read<ClientHomeBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.amber,
      ),
      body: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state) {
          return pageList[ state.pageIdex ];
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
                  decoration: BoxDecoration(color: Colors.blueGrey.shade900),
                  child: SingleChildScrollView(
                    child: _imageLisTitleUser(context, state, clientHomeBloc, user )
                )              
              ),

                ListTile(
                  title: const Text('Perfil de usuario'),
                  selected: state.pageIdex == 0, 
                  // agg el primer valor
                  onTap: ()  {
                    context
                      .read<ClientHomeBloc>()
                      .add(ChangeDrawerPage( pageIdex: 0 ) ); // en el .add agregpo los eventos
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


  Widget _imageLisTitleUser( BuildContext context,  ClientHomeState state, ClientHomeBloc clientHomeBloc, User? user ){
 
  return Column(
    children: [                    
      ListTile( 
        leading:AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
            child: user != null && user.image != null
          ? FadeInImage.assetNetwork(
            placeholder: '/assets/img/user_image.png', 
            image: user.image!,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(seconds: 1),                       
        ) 
          : Image.asset(
            'assets/img/user_image.png',
            fit: BoxFit.cover,
        ),
      ),
    ),
      title: Text( user?.name ?? '', style: const TextStyle( fontWeight: FontWeight.bold, color: Colors.white),),
      selected: state.pageIdex == 0, // agg el primer valor
      onTap: () {
        clientHomeBloc.add(ChangeDrawerPage( pageIdex: 0 ) ); // en el .add agregpo los eventos
        Navigator.pop(context);
      },
     )
   ],
  );
}





