import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/driver/mapLocation/driver_map_location_content.dart';

import 'bloc/index.dart';


class DriverMapLocationPage extends StatefulWidget {
  const DriverMapLocationPage({super.key});

  @override
  State<DriverMapLocationPage> createState() => _DriverMapLocationPageState();
}
class _DriverMapLocationPageState extends State<DriverMapLocationPage> {
  
  String? mapStyle;
  // bool _isInitialized = false;
  // late DriverMapLocationBloc _bloc;
  

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //  if (!_isInitialized) {
      context.read<DriverMapLocationBloc>().add(DriverMapLocationInitEvent());
        print('DRIVER CONECTADO');
      context.read<DriverMapLocationBloc>().add(FindMyPosition());
      // _isInitialized = true;
        print('DRIVER EN POSICION');  
      // } 
    });
    // Cargar estilo del mapa
    rootBundle.loadString('assets/img/style_map.json').then((style) {
      setState(() {
        mapStyle = style;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DriverMapLocationBloc, DriverMapLocationState>(
        builder: (context, state) {
          return DriverMapLocationContent(state, mapStyle: mapStyle);
        },
      ),
    );
  }

}

