import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_elevatedbutton.dart';
import 'bloc/index.dart';

class ClientMapBookingInfoContent extends StatelessWidget {

 final ClientMapBookingInfoState state; 
 final Map<String, dynamic> arguments;
  
const ClientMapBookingInfoContent({super.key, required this.state, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context, state),
        Align(
          alignment: Alignment.bottomCenter,
          child: _cardBookingInfo(context, arguments)
        )
      ],
    );
  }

  Widget _googleMaps(BuildContext context, ClientMapBookingInfoState state) {
    return
      GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPositionBooking,
        polylines: Set<Polyline>.of(state.polylines.values),
        onMapCreated: (GoogleMapController controller) {
          if (state.controller != null) {
            if (!state.controller!.isCompleted) {
              state.controller?.complete(controller);
        }}
      },
    );      
  }

  Widget _cardBookingInfo(BuildContext context, Map<String, dynamic> arguments) {   

    final String pickUpDescription =  arguments['pickUpDescription'];
    final String destinationDescription = arguments['destinationDescription'];

    return 
        Container(
          padding: const EdgeInsets.only( left: 20, right: 20, top: 20),
          width:  double.infinity,
          height: MediaQuery.of(context).size.height * 0.50,
          decoration: const BoxDecoration(
            color:  Colors.white,
            // Color.fromARGB( 255,237,227,213),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child:  Column(       
            children: [
              ListTile(
                title: const Text( 
                  'Recoger en',
                  softWrap: true, // Permite la división automática en líneas
                  maxLines: 3,    // Opcional: límite de líneas visibles
                  overflow: TextOverflow.ellipsis, // Muestra "..." si el texto es demasiado largo
                  ),
                subtitle: Text( pickUpDescription, style: const TextStyle( color: Colors.black38), ) ,
                leading: const Icon(Icons.location_on),
              ),
               ListTile(
                title: const Text( 
                  'Destino',
                  softWrap: true, 
                  maxLines: 3,   
                  overflow: TextOverflow.ellipsis, 
                  ),
                leading: const Icon(Icons.my_location_rounded),
                subtitle: Text( destinationDescription, style: const TextStyle( color: Colors.black38),),
              ),
             const ListTile(
                title: Text( 'Tiempo y distancia',),
                leading: const Icon(Icons.timer_sharp),
                subtitle: Text( '12:00 PM', style: const TextStyle( color: Colors.black38),),
                
              ),
             const ListTile(
                title: Text( 'Precio aproximado del viaje',),
                leading: const Icon(Icons.attach_money),
                subtitle: Text( '19.1 - 25-51 €', style: const TextStyle( color: Colors.black38),),
              ),

              DefaultElevatedButton(
                text: 'SOLICITAR TAXISTA',
                onPressed: () {}, 
                colorFondo: const Color.fromARGB(255, 243, 159, 90,),
                colorLetra: Colors.black
              )
            ]
          ),
        );





  }

  
}
