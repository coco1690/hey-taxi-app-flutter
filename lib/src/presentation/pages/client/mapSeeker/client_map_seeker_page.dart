
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/bloc/client_map_seeker_event.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/mapSeeker/client_map_seeker_content.dart';
import 'bloc/client_map_seeker_state.dart';
class ClientMapSeekerPage extends StatefulWidget {
  const ClientMapSeekerPage({super.key});

  @override
  State<ClientMapSeekerPage> createState() => _ClientMapSeekerPageState();
}

class _ClientMapSeekerPageState extends State<ClientMapSeekerPage> {
  TextEditingController destinationController = TextEditingController();
  TextEditingController pickUpController = TextEditingController();

  // Controladores de foco
  final FocusNode pickUpFocusNode = FocusNode();
  final FocusNode destinationFocusNode = FocusNode();

  // Controlador del DraggableScrollableSheet
  final DraggableScrollableController draggableController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();

    // Escuchar cambios de foco en los TextFields
    pickUpFocusNode.addListener(_handleFocusChange);
    destinationFocusNode.addListener(_handleFocusChange);

    // Inicializar el mapa y buscar posición actual
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapSeekerBloc>().add(ClientMapSeekerInitEvent());
      context.read<ClientMapSeekerBloc>().add(FindMyPosition());
    });
  }

  @override
  void dispose() {
    // Liberar recursos de los FocusNodes
    pickUpFocusNode.dispose();
    destinationFocusNode.dispose();
    super.dispose();
  } 

  void _handleFocusChange() {
  print("FocusNode estado:");
  print("PickUp FocusNode: ${pickUpFocusNode.hasFocus}");
  print("Destination FocusNode: ${destinationFocusNode.hasFocus}");
  
    // Detectar cuando algún TextField recibe el foco y expandir la hoja
    if (pickUpFocusNode.hasFocus || destinationFocusNode.hasFocus) {
      context.read<ClientMapSeekerBloc>().add(OnFocusTextField());

    }else{
      print("Focus perdido.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientMapSeekerBloc, ClientMapSeekerState>(
        builder: (context, state) {
          return ClientMapSeekerContent(
            state,
            destinationController: destinationController,
            pickUpController: pickUpController,
            pickUpFocusNode: pickUpFocusNode,
            destinationFocusNode: destinationFocusNode,
            draggableController: draggableController,
          );
        },
      ),
    );
  }
}
