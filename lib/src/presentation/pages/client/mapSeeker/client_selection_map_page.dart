import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker.bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker.event.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_elevatedbutton.dart';
import 'bloc/client_map_seeker.state.dart';

class ClientSelectionMapPage extends StatefulWidget {
  const ClientSelectionMapPage({super.key});

  @override
  State<ClientSelectionMapPage> createState() => _ClientSelectionMapPageState();
}

class _ClientSelectionMapPageState extends State<ClientSelectionMapPage> {
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
      context.read<ClientMapSeekerBloc>().add(ChangeMapCameraPosition(lat: 4.144223, lng: -73.606649));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientMapSeekerBloc, ClientMapSeekerState>(
        builder: (context, state) {
          return Stack(
            children: [
              // ################  BLOCLISTENER ###################
              BlocListener<ClientMapSeekerBloc, ClientMapSeekerState>(
                listener: (context, state) {
                  if (state.placemarkData != null) {
                    pickUpController.text = state.placemarkData!.address;
                }
              },  
               
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: state.cameraPosition,
                  onCameraMove: (CameraPosition cameraPosition) {
                    context
                        .read<ClientMapSeekerBloc>()
                        .add(OnCameraMove(cameraPosition: cameraPosition));
                  },
                  onCameraIdle: () async {
                    context.read<ClientMapSeekerBloc>().add(OnCameraIdle());
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
              ),
               Container(
                margin: const EdgeInsets.only(top:100, left: 20),
                child: IconButton(
                  
                  highlightColor: Colors.white,
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                    icon: const Icon(Icons.arrow_back_ios_new_rounded), 
                    color: Colors.amber, 
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
                          Navigator.pop(context, pickUpController.text);
                          print(
                              'enviando al map seeker page: $pickUpController');
                        },
                        colorFondo: Colors.amberAccent,
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
        width: 100,
        height: 100,
      ),
    );
  }
}
