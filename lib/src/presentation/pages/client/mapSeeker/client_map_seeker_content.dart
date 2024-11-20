import 'package:flutter/material.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker.bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker.event.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_elevatedbutton.dart';
import 'package:hey_taxi_app/src/presentation/widgets/places_autocomplete_textfield.dart';


class ClientMapSeekerContent extends StatelessWidget {

 final ClientMapSeekerState state;
 final TextEditingController pickUpController;
 final TextEditingController destinationController;

  const ClientMapSeekerContent(this.state, {super.key, required this.pickUpController, required this.destinationController,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context, state),
        _cardAddressDestination(context),
        _iconMyLocation(),
        _buttonSelectedDestination(context),
      ],
    );
  }



// ############ WIDGETS ############

  Widget _googleMaps(BuildContext context, ClientMapSeekerState state) {
    return  GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: state.cameraPosition,
      markers: Set<Marker>.of(state.markers?.values ?? {}),
      onCameraMove: (CameraPosition cameraPosition) {
        context
            .read<ClientMapSeekerBloc>()
            .add(OnCameraMove(cameraPosition: cameraPosition));
      },
      onCameraIdle: () async {
        context.read<ClientMapSeekerBloc>().add(OnCameraIdle());
        pickUpController.text = state.placemarkData?.address ?? '';
        if (state.placemarkData != null) {
          context.read<ClientMapSeekerBloc>().add(OnGoogleAutocompletepickUpSelected(
          lat: state.placemarkData!.lat,
          lng: state.placemarkData!.lng, 
          pickUpDescription: state.placemarkData!.address,
          ));
        }       
      },
      onMapCreated: (GoogleMapController controller) {
        // controller.setMapStyle(
        //     '[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
        if (state.controller != null) {
          if (!state.controller!.isCompleted) {
            state.controller?.complete(controller);
          }
        }
      },
    );
}

  Widget _iconMyLocation() {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/gps-3.png',
        width: 70,
        height: 70,
      ),
    );
  }

  Widget _cardAddressDestination(BuildContext context) {
    return Container(
      height: 162,
      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Card(
        color: const Color.fromARGB(255,	237,	227,	213,),
        shadowColor: Colors.black,
        elevation: 5,
        child: Column(
          children: [

            PleacesAutocompleteTextfield(
              controller: pickUpController,
              label: 'Donde estas',
              onPlaceSelected: (prediction) {
                context.read<ClientMapSeekerBloc>().add(ChangeMapCameraPosition(
                    lat: double.parse(prediction.lat.toString()),
                    lng: double.parse(prediction.lng.toString())));
                context.read<ClientMapSeekerBloc>().add(OnGoogleAutocompletepickUpSelected(
                    lat: double.parse(prediction.lat.toString()),
                    lng: double.parse(prediction.lng.toString()),
                    pickUpDescription: prediction.description.toString(),
                    ));
              },
            ),
            
            PleacesAutocompleteTextfield(
              controller: destinationController,
              label: 'Donde te llevo',
              onPlaceSelected: (prediction) {
                  context.read<ClientMapSeekerBloc>().add(OnGoogleAutocompleteDestinationSelected(
                    lat: double.parse(prediction.lat.toString()),
                    lng: double.parse(prediction.lng.toString()),
                    destinationDescription: prediction.description.toString(),
                    ));
              },
            ),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () async {
                   
                  final result = await Navigator.pushNamed(
                      context,
                      'client/selectionmap',
                    );
                    if (result != null && result is Map<String, dynamic>) {
                      destinationController.text = result['destinationSelection'];
                      print('result: $result');
                    
                    }
                  },
                  icon:  const Icon(Icons.add_location_alt_rounded),
                  label: const Text('Selecciona en el mapa'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonSelectedDestination(BuildContext context) {
    return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 50),
                    child: DefaultElevatedButton(
                        text: 'REVISAR VIAJE',
                        onPressed: () {
                          Navigator.pushNamed(context, 'client/map/booking', 
                          arguments: {
                            
                            'pickUpLatlng':  state.pickUpPLatLng,
                            'destinationLatlng': state.destinationLatLng,
                            'pickUpDescription': state.pickUpDescription,
                            'destinationDescription': state.destinationDescription,
                            
                          }
                          );
                          
                        },
                        colorFondo: const Color.fromARGB(255, 243, 159, 90,),
                        colorLetra: Colors.black),
                  ),
                ],
              );
  }

}