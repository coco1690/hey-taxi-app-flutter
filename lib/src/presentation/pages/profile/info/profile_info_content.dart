import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';


class ProfileInfoContent extends StatelessWidget {

final User? user;
 
const ProfileInfoContent(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
   
    return Stack(
      children: [
        Column(
          children: [
            _headerProfile(context),
            const Spacer(),
            _actionButtonsProfile( context, 'Editar Perfil', Icons.edit, (){
              Navigator.pushNamed(context, 'profile/update', arguments: user);
            }),
            _actionButtonsProfile( context, 'Cerrar sesion', Icons.settings_power, (){}),
            const SizedBox(height: 70,)
           
          ],
        ),
            _cardInfoUser(context, user),
      ],
    );
  }
}

Widget _actionButtonsProfile(BuildContext context, String option, IconData icon, Function() function ){
  return 
  GestureDetector(
   onTap: () {
     function();
   },
    child: ListTile(
      title: Text(option),
      leading: Icon(icon),
    ),
  );
}

Widget _headerProfile(BuildContext context){
  return Column(
      children: [
        Container(
          padding: const EdgeInsets.only( top: 15),
          alignment: Alignment.topCenter,
          height: MediaQuery.of(context).size.height * 0.3,
          width:  MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
         ),
          child: const Text('PERFIL DE USUARIO', style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
        ),
      ],
    );
}

Widget _cardInfoUser( BuildContext context, User? user, ){
  return Container(
    margin: const EdgeInsets.only( left: 20, right: 20, top: 100),
    width: MediaQuery.of(context).size.width,
    height: 260,
    child: Card(
      color: Colors.blueGrey[800],
      child: Column(
        children: [
          Container(
            
            margin: const EdgeInsets.only( top: 20, bottom: 15),
            child: SizedBox(
              width: 115,
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipOval(
                  child: (user != null && user.image != null && user.image!.isNotEmpty)
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
            ),
          ),
        
          Text( user?.name ??  '', style: const TextStyle( color: Colors.white54) ),
          Text( user?.email ?? '', style: const TextStyle( color: Colors.white54) ),
          Text( user?.phone ?? '', style: const TextStyle( color: Colors.white54) ),
      
        ],
      ),
    ),
  );
}