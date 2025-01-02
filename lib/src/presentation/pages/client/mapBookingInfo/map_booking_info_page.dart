import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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
  late ClientMapBookingInfoBloc _bloc;
  StreamSubscription<Position>? positionStreamSubscription;
  bool _isEventDispatched = false;
  String? mapStyle;
  LatLng? pickUpLatlng;
  LatLng? destinationLatlng;
  String? pickUpDescription;
  String? destinationDescription;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ClientMapBookingInfoBloc>();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isEventDispatched) {
     _bloc.add(ClientMapBookingInfoInitEvent(
        pickUpLatlng: pickUpLatlng!,
        destinationLatLng: destinationLatlng!,
        pickUpDescription: pickUpDescription!,
        destinationDescription: destinationDescription!
      ));
      _isEventDispatched = true;
      _bloc.add(GetTimeAndDistanceValues());
      _bloc.add(AddPolyline());

      _bloc.add(ChangeMapCameraPositionMapBookingInfo(
              lat: pickUpLatlng!.latitude, 
              lng: pickUpLatlng!.longitude
          ));  

      }
    });
    
    // Cargar estilo del mapa
    rootBundle.loadString('assets/img/style_map.json').then((style) {
        setState(() {
          mapStyle = style;
        });
      });
  }

  @override
  void dispose() {
    _bloc.add(ResetStateEvent());
    print('RESTART EVENTO EN MAPBOOKINGINFO');
    positionStreamSubscription?.cancel();
    super.dispose();
  }
 

  @override
  Widget build(BuildContext context) {
   final Map<String, dynamic> arguments =
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

      body: BlocListener<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
        listenWhen: (previous, current) => previous.responseClientRequest != current.responseClientRequest,
        listener: (context, state) {
        final responseClientRequest = state.responseClientRequest;

          if (responseClientRequest is Succes) {
           print('created desde mapbookinginfoPage');
            _messageSanckToastSucces(context);
          }
        },

        child: BlocBuilder<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
          buildWhen: (previous, current) => previous.responseTimeAndDistance != current.responseTimeAndDistance,
          builder: (context, state) {
          final responseTimeAndDistance = state.responseTimeAndDistance;

            if (responseTimeAndDistance is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );

            } else if (responseTimeAndDistance is Succes) {
              TimeAndDistanceValues timeAndDistanceValues =
                  responseTimeAndDistance.data as TimeAndDistanceValues;
              print('created desde mapbookinginfoPage TimeAndDistanceValues');

              return ClientMapBookingInfoContent(
                state: state,
                timeAndDistanceValues: timeAndDistanceValues,
                mapStyle: mapStyle,
              );
            }
            return Container();
          }, 
        ),
      ),
    );
  }


  Widget _messageSanckToastSucces(BuildContext context){
      const snack =  SnackBar(
        // key: Key('snackBar'),
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
        title: 'CREATED!',
        message:' Solicitud Creada!!',
        contentType: ContentType.success,
        color:  Color.fromARGB(255, 243, 159, 90),
       
       
      ),
  );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snack);
    return snack;
}
  
}


