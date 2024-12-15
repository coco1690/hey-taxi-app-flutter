import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



import 'bloc/index.dart';



class DriverMapLocationContent extends StatelessWidget {
   
  final DriverMapLocationState state;
  final String? mapStyle;
  

  const DriverMapLocationContent(
    this.state,  {
    super.key,
    required this.mapStyle,
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
        style: mapStyle,
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPosition,
        markers: Set<Marker>.of(state.markers.values),
        onCameraMove: (CameraPosition cameraPosition) {
          context
              .read<DriverMapLocationBloc>();
             
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
