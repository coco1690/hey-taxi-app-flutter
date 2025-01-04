
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
              title: _textOffered(),
              subtitle: Text( clientRequestResponse?.client.name ?? '', style: const TextStyle( color: Color.fromARGB(255, 255, 255, 255) ) ),
            ),
            ListTile(
              title: const Text('Datos del viaje',style: TextStyle( color: Color.fromARGB(255, 230, 254, 83) )),
              subtitle: Column(
                children: [
                  _textPickup(),
                  _textDestination()
                ]
              ),
            ),
            ListTile(
              title: const Text('Tiempo y distancia',style: TextStyle( color: Color.fromARGB(255, 230, 254, 83) )),
              subtitle: Column(
                children: [
                  _textDuration(),
                  _textDistance()
                ]
              ),
            ),           
          ]
        )
      );
  }

  Widget _textOffered(){
    return Row(
      children: [
        const Icon(Icons.attach_money_rounded, color:Color.fromARGB(255, 230, 254, 83)),
        const Text('Tarifa: ',style: TextStyle( color:Color.fromARGB(255, 230, 254, 83), fontSize: 15, fontWeight: FontWeight.bold )),
        Expanded(
          child: Text(
             clientRequestResponse?.fareOffered?.toString() ?? '\$ 26.000',
             style: const  TextStyle( color:Color.fromARGB(255, 254, 171, 83), fontSize: 15, fontWeight: FontWeight.bold ),
             softWrap: true,
             overflow: TextOverflow.ellipsis,         
          ), 
        ),   
         Expanded(
          child: Text(
             clientRequestResponse?.metodPay ?? '',
             style: const  TextStyle( color:Color.fromARGB(255, 254, 171, 83), fontSize: 15, fontWeight: FontWeight.bold ),
             softWrap: true,
             overflow: TextOverflow.ellipsis,         
          ), 
        ),     
      ],
    );
  }

  Widget _textPickup(){
    return Row(
      children: [
        const Icon(Icons.location_on, color:Color.fromARGB(255, 230, 254, 83)),
        const Text(' Recoger en: ',style: TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold )),
        Expanded(
          child: Text(
             clientRequestResponse?.pickupDescription ?? '',
             style: const  TextStyle( color: Colors.white),
             softWrap: true,
             overflow: TextOverflow.ellipsis,
             
          ), 
        ),       
      ],
    );
  }

  Widget _textDestination(){
    return Row(
      children: [
        const Icon(Icons.my_location, color:Color.fromARGB(255, 230, 254, 83)),
        const Text(' llevar a: ',style: TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold )),
        Expanded(
          child: Text(
             clientRequestResponse?.destinationDescription ?? '',
             style: const TextStyle( color: Colors.white),
             softWrap: true,
             overflow: TextOverflow.ellipsis,
             
             ), 
        ),
        
      ],
    );
  }

  Widget _textDuration(){
    return Row(
      children: [
        const Icon(Icons.timer_outlined, color:Color.fromARGB(255, 230, 254, 83)),
        const Text(' Tiempo: ',style: TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold )),
        Expanded(
          child: Text(
             clientRequestResponse?.googleDistanceMatrix.duration.text ?? '',
             style: const TextStyle( color: Colors.white),
             softWrap: true,
             overflow: TextOverflow.ellipsis,         
          ), 
        ),    
      ],
    );
  }

  Widget _textDistance(){
    return Row(
      children: [
        const Icon(Icons.social_distance_rounded, color:Color.fromARGB(255, 230, 254, 83)),
        const Text(' Distancia: ',style: TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold )),
        Expanded(
          child: Text(
             clientRequestResponse?.googleDistanceMatrix.distance.text ?? '',
             style: const TextStyle( color: Colors.white),
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