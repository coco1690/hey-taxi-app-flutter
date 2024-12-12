import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/models/time_and_distance_values.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapBookingInfo/map_booking_info_content.dart';

import 'bloc/index.dart';


class MapBookingInfoPage extends StatefulWidget {
  const MapBookingInfoPage({super.key});

  @override
  State<MapBookingInfoPage> createState() => _MapBookingInfoPageState();
}

class _MapBookingInfoPageState extends State<MapBookingInfoPage> {

  LatLng? pickUpLatlng; 
  LatLng? destinationLatlng; 
  String? pickUpDescription; 
  String? destinationDescription; 


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapBookingInfoBloc>().add(ClientMapBookingInfoInitEvent(
        pickUpPLatLng: pickUpLatlng!,
        destinationLatLng: destinationLatlng!, 
        pickUpDescription: pickUpDescription!, 
        destinationDescription: destinationDescription!
      ));
      context.read<ClientMapBookingInfoBloc>().add(GetTimeAndDistanceValues());
      context.read<ClientMapBookingInfoBloc>().add(AddPolyline());
      context.read<ClientMapBookingInfoBloc>().add(ChangeMapCameraPositionMapBookingInfo( 
        lat: pickUpLatlng!.latitude, 
        lng: pickUpLatlng!.longitude
        ));     
    });
     
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      pickUpLatlng = arguments['pickUpLatlng'];
      destinationLatlng = arguments['destinationLatlng'];
      pickUpDescription = arguments['pickUpDescription'];
      destinationDescription = arguments['destinationDescription'];
    
  //    if (arguments == null) {
  //   return const Center(
  //     child: Text('Error: No se encontraron argumentos'),
  //   );
  // }
    return Scaffold(
      body: BlocBuilder<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
        builder: (context, state) {
         final responseTimeAndDistance = state.responseTimeAndDistance;

          if (responseTimeAndDistance is Loading) { 
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          else if (responseTimeAndDistance is Succes) { 
            TimeAndDistanceValues timeAndDistanceValues = responseTimeAndDistance.data as TimeAndDistanceValues;
            return ClientMapBookingInfoContent(  state: state, timeAndDistanceValues: timeAndDistanceValues);
          }
          return Container();
        },
      ),
    );
  } 
}
