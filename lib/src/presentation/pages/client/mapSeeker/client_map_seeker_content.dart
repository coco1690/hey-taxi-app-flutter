import 'package:flutter/material.dart';

import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker_event.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_button_animation.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_elevatedbutton.dart';
import 'package:hey_taxi_app/src/presentation/widgets/places_autocomplete_textfield.dart';

class ClientMapSeekerContent extends StatelessWidget {
  final ClientMapSeekerState state;
  final TextEditingController pickUpController;
  final TextEditingController destinationController;
  final FocusNode pickUpFocusNode;
  final FocusNode destinationFocusNode;
  final DraggableScrollableController draggableController;
  final ValueNotifier<String> pickUpNotifier;
  final String? mapStyle;

  const ClientMapSeekerContent(
    this.state, {
    super.key,
    required this.pickUpController,
    required this.destinationController,
    required this.pickUpFocusNode,
    required this.destinationFocusNode,
    required this.draggableController,
    required this.pickUpNotifier,
    required this.mapStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context, state),
        _iconMyLocation(context),

        // BlocListener para manejar la expansión de la hoja
        BlocListener<ClientMapSeekerBloc, ClientMapSeekerState>(
          listenWhen: (previous, current) =>
              previous.shouldExpandSheet != current.shouldExpandSheet,
          listener: (context, state) {
            if (state.shouldExpandSheet) {
              draggableController.animateTo(
                0.85,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              // Dispara evento para reiniciar el foco
              context.read<ClientMapSeekerBloc>().add(ResetExpandSheetEvent());
            }
          },
          child: _cardAddressDestination(context),
        ),
      ],
    );
  }

// ############ WIDGETS ############

  Widget _googleMaps(BuildContext context, ClientMapSeekerState state) {
    
    return BlocListener<ClientMapSeekerBloc, ClientMapSeekerState>(
      listenWhen: (previous, current) =>previous.placemarkData?.address != current.placemarkData?.address,
      listener: (context, state) {

      print('LISTEN WHEN ${state.placemarkData?.address}');
         if (state.placemarkData != null) {                 
      pickUpController.text =  state.placemarkData?.address ?? '';
        context
        .read<ClientMapSeekerBloc>()
        .add(OnGoogleAutocompletepickUpSelected(
          lat: state.placemarkData!.lat,
          lng: state.placemarkData!.lng,
          pickUpDescription: state.placemarkData!.address,
        ));  
        }
      },
      child: GoogleMap(
        style: mapStyle,
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPosition,
        markers: Set<Marker>.of(state.markers.values),
        onCameraMove: (CameraPosition cameraPosition) {
          context
              .read<ClientMapSeekerBloc>()
              .add(OnCameraMove(cameraPosition: cameraPosition));
        },
        onCameraIdle: () async {
          context.read<ClientMapSeekerBloc>().add(OnCameraIdle());        
        },
        myLocationEnabled: true,
      ),
    );
  }

  Widget _iconMyLocation(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/user_pin.png',
        width: 40,
        height: 40,
      ),
    );
  }

  Widget _cardAddressDestination(BuildContext context) {
    return Stack(
      children: [
        DraggableScrollableSheet(
          controller: draggableController,
          initialChildSize: 0.42, // Tamaño inicial
          minChildSize: 0.42, // Tamaño mínimo al colapsarse
          maxChildSize: 0.85, // Tamaño máximo al expandirse
          // expand: false,

          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(173, 7, 9, 18),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.center,
                        child: ScalingButton(
                          imagePath: 'assets/img/thunder.png',
                          onPressed: () {
                            print('Botón animado presionado');
                            // Lógica al presionar el botón
                          },
                          duration:
                              const Duration(seconds: 1), // Rotación más rápida
                          minScale: 0.9, // Tamaño mínimo al escalar
                          maxScale: 1.5,
                          text:
                              'SOLICITAR TAXI', // Tamaño máximo al escalar// Botón más grande
                        ),
                      ),
                      Spacer(),
                      _butonCloseSheet(context),
                    ],
                  ),
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Stack(children: [
                      Column(
                        children: [
                          Center(
                              //RAYA DE CABECERA CENTRADA
                              child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 3,
                            width: double.infinity,
                            color: Colors.white38,
                          )),

                          BlocListener<ClientMapSeekerBloc,
                              ClientMapSeekerState>(
                            
                            listener: (context, state) {
                              if (state.placemarkData != null) {
                                pickUpNotifier.value =
                                    state.placemarkData!.address;
                              }
                            },
                            child: ValueListenableBuilder<String>(
                              valueListenable: pickUpNotifier,
                              builder: (context, value, child) {
                                return PleacesAutocompleteTextfield(
                                  controller: pickUpController,
                                  focusNode: pickUpFocusNode,
                                  label: 'De',
                                  onPlaceSelected: (prediction) {
                                    context.read<ClientMapSeekerBloc>().add(
                                          OnGoogleAutocompletepickUpSelected(
                                            lat: double.parse(
                                                prediction.lat.toString()),
                                            lng: double.parse(
                                                prediction.lng.toString()),
                                            pickUpDescription: prediction
                                                .description
                                                .toString(),
                                          ),
                                        );
                                  },
                                );
                              },
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          PleacesAutocompleteTextfield(
                            controller: destinationController,
                            label: 'A',
                            focusNode: destinationFocusNode,
                            onPlaceSelected: (prediction) {
                              context.read<ClientMapSeekerBloc>().add(OnGoogleAutocompleteDestinationSelected(
                                    lat:double.parse(prediction.lat.toString()),
                                    lng:double.parse(prediction.lng.toString()),
                                    destinationDescription:
                                        prediction.description.toString(),
                                  ));
                            },
                          ),
                          Row(
                            children: [
                              _textBottonSelectOnMapDestination(context),
                            ],
                          ),
                          _buttonSelectedDestination(context),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buttonSelectedDestination(BuildContext context) {
    final isButtonEnabled = pickUpController.text.isNotEmpty &&
        destinationController.text.isNotEmpty;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      // color: Colors.white,
      margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),

      child: BlocListener<ClientMapSeekerBloc, ClientMapSeekerState>(
        listener: (context, state) {
          context.read<ClientMapSeekerBloc>().add(
              OnUpdaateButtonEstate(isButtonEnabled: state.isButtonEnabled));
        },
        child: DefaultElevatedButton(
          text: 'REVISAR VIAJE',
          onPressed: isButtonEnabled
              ? () {
                  Navigator.pushNamed(
                    context,
                    'client/map/booking',
                    arguments: {
                      'pickUpLatlng': state.pickUpPLatLng,
                      'destinationLatlng': state.destinationLatLng,
                      'pickUpDescription': state.pickUpDescription,
                      'destinationDescription': state.destinationDescription,
                    },
                  );
                }
              : null, // Desactiva el botón
          colorFondo: isButtonEnabled
              ? const Color.fromARGB(255, 243, 159, 90)
              : Colors.grey, // Cambia el color si está deshabilitado
          colorLetra: isButtonEnabled ? Colors.black : Colors.white38,
        ),
      ),
    );
  }

  Widget _textBottonSelectOnMapDestination(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        final result = await Navigator.pushNamed(
          context,
          'client/destinationmap',
        );
        if (result != null && result is Map<String, dynamic>) {
          destinationController.text = result['destinationSelection'] ?? '';
          context.read<ClientMapSeekerBloc>().add(
                OnGoogleAutocompleteDestinationSelected(
                  lat: result['lat'] ?? 0.0,
                  lng: result['lng'] ?? 0.0,
                  destinationDescription: result['destinationSelection'] ?? '',
                ),
              );
        }
      },
      icon: const Icon(Icons.add_location_alt_rounded,
          color: Color.fromARGB(255, 230, 254, 83)),
      label: const Text('Selecciona en el mapa',
          style: TextStyle(color: Color.fromARGB(255, 230, 254, 83))),
    );
  }

  Widget _butonCloseSheet(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: IconButton(
        //  highlightColor: const Color.fromARGB(255, 85, 85, 85),
        onPressed: () {
          draggableController.animateTo(
            0.3, // Expande al 100%
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );

          // Desfoca los TextFields
          pickUpFocusNode.unfocus();
          destinationFocusNode.unfocus();
        },
        icon: const Icon(Icons.close_rounded, size: 25, color: Colors.white38),
      ),
    );
  }
}
