import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



import 'bloc/index.dart';



class DriverMapLocationContent extends StatelessWidget {

  final DriverMapLocationState state;
  

  const DriverMapLocationContent(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context, state),
        // _iconMyLocation(context),
      ],
    );
  }

// ############ WIDGETS ############

  Widget _googleMaps(BuildContext context, DriverMapLocationState state) {
    return 
       GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPosition,
        markers: Set<Marker>.of(state.markers.values),
        onCameraMove: (CameraPosition cameraPosition) {
          context
              .read<DriverMapLocationBloc>()
              .add(OnCameraMove(cameraPosition: cameraPosition));
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

  // Widget _iconMyLocation(
  //   BuildContext context,
  // ) {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 25),
  //     alignment: Alignment.center,
  //     child: Image.asset(
  //       'assets/img/gps-3.png',
  //       width: 70,
  //       height: 70,
  //     ),
  //   );
  // }

 
}
