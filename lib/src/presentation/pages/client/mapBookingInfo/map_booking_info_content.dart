import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/models/time_and_distance_values.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_elevatedbutton.dart';
import 'bloc/index.dart';

class ClientMapBookingInfoContent extends StatelessWidget {
  final ClientMapBookingInfoState state;
  final TimeAndDistanceValues timeAndDistanceValues;
  final String? mapStyle;
  // final Map<String, dynamic> arguments;

  const ClientMapBookingInfoContent(
      {super.key,
      required this.state,
      required this.timeAndDistanceValues,
      required this.mapStyle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context, state),
        _iconButtonBack(context, state),
        _draggableCardBookingInfo(context, timeAndDistanceValues),
        Positioned(
          bottom: 25,
          right: 15,
          child: FloatingActionButton(
            onPressed: () {
              // Centrar el mapa en la ubicación del usuario.
              context.read<ClientMapBookingInfoBloc>().add(CenterMapOnUserLocation());  
            },
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }

  Widget _iconButtonBack(
      BuildContext context, ClientMapBookingInfoState state) {
    return Container(
        margin: const EdgeInsets.only(top: 100, left: 20),
        child: IconButton(
          highlightColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: const Color.fromARGB(
            255,
            243,
            159,
            90,
          ),
          iconSize: 40,
        ));
  }

  Widget _googleMaps(BuildContext context, ClientMapBookingInfoState state) {
    return BlocBuilder<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
      buildWhen: (previous, current) => previous.polylines != current.polylines,
      builder: (context, state) {

        return GoogleMap(

          style: mapStyle,
          mapType: MapType.normal,
          initialCameraPosition: state.cameraPositionBooking,
          markers: Set<Marker>.of(state.markers.values),
          polylines: Set<Polyline>.of(state.polylines.values),
          onMapCreated: (GoogleMapController controller)  {   // INICIALIZO EL MAPA
              if (!state.controller!.isCompleted) {
                state.controller!.complete(controller);
              }
            },
        );
      },
    );
  }

  Widget _draggableCardBookingInfo(
      BuildContext context, TimeAndDistanceValues timeAndDistanceValues) {
    String distance = timeAndDistanceValues.distance.text;
    String duration = timeAndDistanceValues.duration.text;
    int? recommendedValue = timeAndDistanceValues.recommendedValue;

    int? approximateValue(int? recommendedValue) {
      return recommendedValue?.round();
    }
    // int    roundedRecomendedValue = recommendedValue.round();

    return BlocBuilder<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
      buildWhen: (previous, current) =>
          previous.pickUpDescription != current.pickUpDescription ||
          previous.destinationDescription != current.destinationDescription,
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.45, // Tamaño inicial
          minChildSize: 0.2, // Tamaño mínimo al colapsarse
          maxChildSize: 0.46, // Tamaño máximo al expandirse
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
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
                  )),
                  ListTile(
                    title: const Text('Origen'),
                    subtitle: Text(state.pickUpDescription,
                        style: const TextStyle(color: Colors.black38)),
                    leading: const Icon(Icons.location_on),
                  ),
                  ListTile(
                    title: const Text('Destino'),
                    subtitle: Text(state.destinationDescription,
                        style: const TextStyle(color: Colors.black38)),
                    leading: const Icon(Icons.my_location_rounded),
                  ),
                  ListTile(
                    title: const Text('Tiempo / Distancia / Precio aprox'),
                    subtitle: Text(
                        '$duration / $distance / \$ ${approximateValue(recommendedValue)}',
                        style: const TextStyle(color: Colors.black38)),
                    leading: const Icon(Icons.timer_sharp),
                  ),
                  //  ListTile(
                  //   title: const Text('Precio aproximado del viaje'),
                  //   subtitle: Text( '\$ ${approximateValue(recommendedValue)}',
                  //       style: const TextStyle(color: Colors.black38)),
                  //   leading: const  Icon(Icons.attach_money),
                  // ),
                  // DefaultElevatedButton(
                  //   text: 'SOLICITAR TAXISTA',
                  //   onPressed: () {
                  //     context.read<ClientMapBookingInfoBloc>().add(CreateClientRequest());
                  //     print('SOLICIAR TAXISTA CLIENT DESDE MAPBOOKINGINFO');
                  //   },
                  //   colorFondo: const Color.fromARGB(255, 243, 159, 90),
                  //   colorLetra: Colors.black,
                  // ),
                  DefaultElevatedButton(
                    text: 'SOLICITAR TAXISTA',
                    onPressed: state.responseClientRequest is! Loading
                        ? () {
                            context
                                .read<ClientMapBookingInfoBloc>()
                                .add(CreateClientRequest());
                            print(
                                'SOLICITAR TAXISTA CLIENT DESDE MAPBOOKINGINFO');
                          }
                        : null, // Deshabilitar el botón si ya está procesando
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
