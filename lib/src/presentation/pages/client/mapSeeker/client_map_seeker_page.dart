import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker.bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker.event.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/client_map_seeker_content.dart';
import 'bloc/client_map_seeker.state.dart';

class ClientMapSeekerPage extends StatefulWidget {
  const ClientMapSeekerPage({super.key});

  @override
  State<ClientMapSeekerPage> createState() => _ClientMapSeekerPageState();
}
class _ClientMapSeekerPageState extends State<ClientMapSeekerPage> {
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  TextEditingController destinationController = TextEditingController();
  TextEditingController pickUpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapSeekerBloc>().add(ClientMapSeekerInitEvent());
      context.read<ClientMapSeekerBloc>().add(FindMyPosition());
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientMapSeekerBloc, ClientMapSeekerState>(
        builder: (context, state) {
          return ClientMapSeekerContent(state, destinationController: destinationController, pickUpController: pickUpController);
        },
      ),
    );
  }



}

