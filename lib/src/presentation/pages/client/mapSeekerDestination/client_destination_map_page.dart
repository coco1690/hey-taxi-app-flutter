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
                    controller.setMapStyle(
                      '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]'
                  );
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
        'assets/img/user_pin.png',
        width: 40,
        height: 40,
      ),
    );
  }
}
