import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/driver/mapLocation/driver_map_location_content.dart';

import 'bloc/index.dart';


class DriverMapLocationPage extends StatefulWidget {
  const DriverMapLocationPage({super.key});

  @override
  State<DriverMapLocationPage> createState() => _DriverMapLocationPageState();
}
class _DriverMapLocationPageState extends State<DriverMapLocationPage> {
  late DriverMapLocationBloc _bloc;
  
   @override
  void initState() {
    super.initState();
    _bloc = context.read<DriverMapLocationBloc>();
    _bloc.add(DriverMapLocationInitEvent());
    _bloc.add(ConnectSocketIo());
    print('DRIVER CONECTADO');
    _bloc.add(FindMyPosition());
    print('DRIVER EN POSICION');
  }

  @override
  void dispose() {
    _bloc.add(StopLocation());
    _bloc.add(DisconnectSocketIo());
    print('DRIVER DESCONECTADO');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DriverMapLocationBloc, DriverMapLocationState>(
        builder: (context, state) {
          return DriverMapLocationContent(state );
        },
      ),
    );
  }



}

