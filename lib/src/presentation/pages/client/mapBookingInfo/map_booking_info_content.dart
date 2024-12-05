import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_elevatedbutton.dart';
import 'bloc/index.dart';

class ClientMapBookingInfoContent extends StatelessWidget {
  final ClientMapBookingInfoState state;
  final Map<String, dynamic> arguments;

  const ClientMapBookingInfoContent(
      {super.key, required this.state, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context, state),
        _draggableCardBookingInfo(context, arguments),
        Positioned(
          bottom: 25,
          right: 15,
          child: FloatingActionButton(
            onPressed: () {
              // Centrar el mapa en la ubicación del usuario.
            },
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }

  Widget _googleMaps(BuildContext context, ClientMapBookingInfoState state) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: state.cameraPositionBooking,
      markers: Set<Marker>.of(state.markers.values),
      polylines: Set<Polyline>.of(state.polylines.values),
      onMapCreated: (GoogleMapController controller) {
        if (state.controller != null) {
          if (!state.controller!.isCompleted) {
            state.controller?.complete(controller);
          }
        }
      },
    );
  }

  Widget _draggableCardBookingInfo(BuildContext context, arguments) {
    final String pickUpDescription = arguments['pickUpDescription'];
    final String destinationDescription = arguments['destinationDescription'];

    return BlocBuilder<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
      builder: (context, state) {
       

        return DraggableScrollableSheet(
          initialChildSize: 0.3, // Tamaño inicial
          minChildSize: 0.2, // Tamaño mínimo al colapsarse
          maxChildSize: 0.6, // Tamaño máximo al expandirse
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Center(
                    child: Container(
                      height: 3,
                      width: 50,
                      color: Colors.black54,
                    )
                  ),
                  ListTile(
                    title: const Text('Recoger en'),
                    subtitle: Text(pickUpDescription,
                        style: const TextStyle(color: Colors.black38)),
                    leading: const Icon(Icons.location_on),
                  ),
                  ListTile(
                    title: const Text('Destino'),
                    subtitle: Text(destinationDescription,
                        style: const TextStyle(color: Colors.black38)),
                    leading: const Icon(Icons.my_location_rounded),
                  ),
                  const ListTile(
                    title: Text('Tiempo y distancia'),
                    subtitle: Text('12:00 PM',
                        style: TextStyle(color: Colors.black38)),
                    leading: Icon(Icons.timer_sharp),
                  ),
                  const ListTile(
                    title: Text('Precio aproximado del viaje'),
                    subtitle: Text('19.1 - 25.51 €',
                        style: TextStyle(color: Colors.black38)),
                    leading: Icon(Icons.attach_money),
                  ),
                  DefaultElevatedButton(
                    text: 'SOLICITAR TAXISTA',
                    onPressed: () {},
                    colorFondo: const Color.fromARGB(255, 243, 159, 90),
                    colorLetra: Colors.black,
                  ),
                ],
              ),
            );             
          },        
        );       
      },   
    );
    
  }
  
}
