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
              .read<DriverMapLocationBloc>();
             
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
