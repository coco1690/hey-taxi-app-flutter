
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hey_taxi_app/src/domain/models/client_request_response.dart';
import 'bloc/driver_client_requests_state.dart';

class DriverClientRequestsItem extends StatelessWidget {

  final DriverClientRequestsState state;
  final ClientRequestResponse? clientRequestResponse;

 const  DriverClientRequestsItem({
    super.key,
    required this.state,
    required this.clientRequestResponse,
  });

  @override
  Widget build(BuildContext context) {
    
    return 
    Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        // shadowColor: const Color.fromARGB(255, 230, 254, 83),
       
         color:const Color.fromARGB(255, 44, 47, 55),
        elevation: 2,
         child:Column(
          children: [
             ListTile(
              trailing: _imageMyUser( context, state, clientRequestResponse ),
              title: const Text('Nombre del cliente', style: TextStyle( color: Color.fromARGB(255, 230, 254, 83) )),
              subtitle: Text( clientRequestResponse?.client.name ?? '', style: const TextStyle( color: Color.fromARGB(255, 255, 255, 255) ) ),
            ),
            ListTile(
              title: const Text('Datos del viaje',style: TextStyle( color: Color.fromARGB(255, 230, 254, 83) )),
              subtitle: _textPickup()
            ),
          ]
        )
      );
  }

  Widget _textPickup(){
    return Row(
      children: [
        const Icon(Icons.location_on, color:Color.fromARGB(255, 230, 254, 83)),
        const Text('Recoger en: ',style: TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold )),
        Expanded(
          child: Text(
             clientRequestResponse?.pickupDescription ?? '',
             style: TextStyle( color: Colors.white),
             softWrap: true,
             overflow: TextOverflow.ellipsis,
             
             ), 
        ),
        
      ],
    );
  }

  Widget _imageMyUser( BuildContext context, DriverClientRequestsState state, ClientRequestResponse? clientRequestResponse ) {
    return Container(
            margin: const EdgeInsets.only( bottom: 10, top: 10),
            height: 150,
            child: AspectRatio(
              aspectRatio: 1,
            child: ClipOval(
              child:( clientRequestResponse?.client.image != null )
              ? CachedNetworkImage(
                imageUrl: clientRequestResponse?.client.image ?? '',
                placeholder: (context, url ) => Image.asset('assets/img/user_image.png'),
                errorWidget: (context, url, error) => Image.asset('assets/img/user_menu.png'),
                fit: BoxFit.cover,
              )
              : Image.asset(
                'assets/img/user_image.png',
                fit: BoxFit.cover,
                ),
                
            )
          ),
        );
  }
}