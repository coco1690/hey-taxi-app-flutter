import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBookingInfoPage extends StatefulWidget {
  const MapBookingInfoPage({super.key});

  @override
  State<MapBookingInfoPage> createState() => _MapBookingInfoPageState();
}

class _MapBookingInfoPageState extends State<MapBookingInfoPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    LatLng? pickUpLatlng = arguments['pickUpLatlng'];
    LatLng? destinationLatlng = arguments['destinationLatlng'];
    String pickUpDescription = arguments['pickUpDescription'];
    String destinationDescription = arguments['destinationDescription'];
    print('pickUpLatlng: ${pickUpLatlng?.toJson()}');
    print('destinationLatlng: ${destinationLatlng?.toJson()}');
    print('pickUpDescription: $pickUpDescription');
    print('destinationDescription: $destinationDescription');

    return  Scaffold(
      body: Center(
        child: Text(arguments.toString()),
      ),
    );
  }
}