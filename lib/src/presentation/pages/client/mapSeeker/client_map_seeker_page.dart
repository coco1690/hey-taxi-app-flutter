import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker.bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker.event.dart';
import 'package:hey_taxi_app/src/presentation/widgets/places_autocomplete_textfield.dart';
import 'bloc/client_map_seeker.state.dart';

class ClientMapSeekerPage extends StatefulWidget {
  const ClientMapSeekerPage({super.key});

  @override
  State<ClientMapSeekerPage> createState() => _ClientMapSeekerPageState();
}

class _ClientMapSeekerPageState extends State<ClientMapSeekerPage> {
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(4.144223, -73.606649),
  //   zoom: 14.4746,
  // );

  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapSeekerBloc>().add(ClientMapSeekerInitEvent());
      context.read<ClientMapSeekerBloc>().add(FindMyPosition());
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientMapSeekerBloc, ClientMapSeekerState>(
        builder: (context, state) {
          return Stack(
            children: [
                 GoogleMap(
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
                  },
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(
                        '[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
                    if (state.controller != null) {
                      if (!state.controller!.isCompleted) {
                        state.controller?.complete(controller);
                      }
                    }
                  },
                ),
              
              _cardAddressDestination(context),
              _iconMyLocation(),
            ],
          );
        },
      ),
    );
  }

  Widget _iconMyLocation() {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/gps-3.png',
        width: 100,
        height: 100,
      ),
    );
  }

  Widget _cardAddressDestination(BuildContext context) {
    return Container(
      height: 162,
      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Card(
        color: Colors.white,
        shadowColor: Colors.amberAccent,
        elevation: 5,
        child: Column(
          children: [
            PleacesAutocompleteTextfield(
              controller: pickUpController,
              // hintText: 'Donde estas',
              label: 'Donde estas',
              onPlaceSelected: (prediction) {
                context.read<ClientMapSeekerBloc>().add(ChangeMapCameraPosition(
                    lat: double.parse(prediction.lat.toString()),
                    lng: double.parse(prediction.lng.toString())));
              },
            ),
            PleacesAutocompleteTextfield(
              controller: destinationController,
              // hintText: 'Donde te llevo',
              label: 'Donde te llevo',
              onPlaceSelected: (prediction) {
                print('Donde te llevo lat: ${prediction.lat}');
                print('Donde te llevo lng: ${prediction.lng}');
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
                    if (result != null) {
                      destinationController.text = result.toString();
                    }
                  },
                  icon: const Icon(Icons.add_location_alt_rounded),
                  label: const Text('Selecciona en el mapa'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const ClientSelectionMapPage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

}

