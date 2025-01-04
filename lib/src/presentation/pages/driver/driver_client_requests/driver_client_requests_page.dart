import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/client_request_response.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/pages/driver/driver_client_requests/bloc/driver_client_requests_state.dart';
import 'package:hey_taxi_app/src/presentation/pages/driver/driver_client_requests/driver_client_requests_item.dart';

import 'bloc/driver_client_requests_bloc.dart';
import 'bloc/driver_client_requests_event.dart';




class DriverClientRequestsPage extends StatefulWidget {
   
  const DriverClientRequestsPage({super.key});

  @override
  State<DriverClientRequestsPage> createState() => _DriverClientRequestsPageState();
}


class _DriverClientRequestsPageState extends State<DriverClientRequestsPage> {

  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    context.read<DriverClientRequestsBloc>().add(GetNearbyClientRequest());
    context.read<DriverClientRequestsBloc>().add(ListenNewClientRequestSocketIO());
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 7, 7),
      ),
      backgroundColor: const Color.fromARGB(255, 7, 7, 7),
      body: BlocBuilder<DriverClientRequestsBloc, DriverClientRequestsState>(
        builder: (context, state) {
          final response = state.response;
          
          if (response is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (response is Succes) {
            List<ClientRequestResponse> clientRequestResponses = response.data as List<ClientRequestResponse>;
            if (clientRequestResponses.isEmpty) {
              return const Center(
                child: Text(' No hay solicitudes de viajes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 230, 254, 83) )),
              );
            }
            return Container(
              // margin: const EdgeInsets.only(top: 60),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(        
              itemCount: clientRequestResponses.length, // Obtener la cantidad de items en la lista
              itemBuilder: (context, index) {
  
                return DriverClientRequestsItem( state: state, clientRequestResponse: clientRequestResponses[index] );
              },
            ),         
          );
        } 
          return  const Center(
            child: Text('Error: No se encontraron solicitudes de viajes', style: TextStyle(color: Color.fromARGB(255, 235, 6, 6))),
          );
        },
      ),
    );
  }
}