import 'package:flutter/material.dart';
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
        // onCameraMove: (CameraPosition cameraPosition) {
        //   context
        //       .read<DriverMapLocationBloc>();     
        // },
         onMapCreated: (GoogleMapController controller) {
      // Verifica que el controller no sea null
      if (state.controller != null && !state.controller!.isCompleted) {
        state.controller!.complete(controller);
      } else {
        print('Error: Controller no está inicializado en el estado.');
      }
    },
    );
  }

}
