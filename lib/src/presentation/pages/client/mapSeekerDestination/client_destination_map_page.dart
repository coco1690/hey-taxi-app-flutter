import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_elevatedbutton.dart';
import 'bloc/index.dart';

class ClientDestinationMapPage extends StatefulWidget {
  const ClientDestinationMapPage({super.key});

  @override
  State<ClientDestinationMapPage> createState() => _ClientDestinationMapPageState();
}

class _ClientDestinationMapPageState extends State<ClientDestinationMapPage> {
 
  TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientDestinationMapBloc>().add(ClientDestinationMapInitEvent());
      context.read<ClientDestinationMapBloc>().add(FindMyPositionDestinationMap());
      // context.read<ClientDestinationMapBloc>().add(ChangeMapCameraPositionDestination(lat: 4.144223, lng: -73.606649));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientDestinationMapBloc, ClientDestinationMapState>(
        builder: (context, state) {
          return Stack(
            children: [
              // ################  BLOCLISTENER ###################
              BlocListener<ClientDestinationMapBloc, ClientDestinationMapState>(
                listener: (context, state) {
                  if (state.placemarkData != null) {                 
                      destinationController.text = state.placemarkData!.address;     
                                                  
                      context.read<ClientDestinationMapBloc>().add(OnGoogleAutocompleteSelectedDestinationMap(
                      lat: state.placemarkData!.lat,
                      lng: state.placemarkData!.lng, 
                      destinationDescription: state.placemarkData!.address,
                    ));
                }
              },  
               
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: state.cameraPositionDestination,
                  onCameraMove: (CameraPosition cameraPosition) {
                    context.read<ClientDestinationMapBloc>().add(OnCameraMoveDestination(cameraPosition: cameraPosition)
                    );
                  },
                onCameraIdle: () async {                  
                  context.read<ClientDestinationMapBloc>().add(OnCameraIdleDestination());
                  
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
                ),
              ), 
               Container(
                margin: const EdgeInsets.only(top:100, left: 20),
                child: IconButton(
                  
                  highlightColor: Colors.white,
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                    icon: const Icon(Icons.arrow_back_ios_new_rounded), 
                    color: const Color.fromARGB(255, 243, 159, 90,), 
                    iconSize: 40,
                  )
                ),
              _iconMyLocation(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 50),
                    child: DefaultElevatedButton(
                        text: 'SELECCIONA EL DESTINO',
                        onPressed: () {
                          final arg = { 
                            'destinationSelection': destinationController.text, 
                            'lat': state.cameraPositionDestination.target.latitude, 
                            'lng': state.cameraPositionDestination.target.longitude 
                          };
                          Navigator.pop(context, arg);
                          print(
                              'enviando al map seeker page: ${arg}');
                        },
                        colorFondo: const Color.fromARGB(255, 243, 159, 90,),
                        colorLetra: Colors.black),
                  ),
                ],
              )
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
        width: 70,
        height: 70,
      ),
    );
  }
}
