import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/role.dart';
import 'package:hey_taxi_app/src/presentation/pages/roles/bloc/roles_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/roles/bloc/roles_state.dart';
import 'package:hey_taxi_app/src/presentation/pages/roles/roles_item.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RolesBloc, RolesState>(
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            decoration: const  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  //  Color.fromARGB(255, 229, 244, 19),
                  //  Color.fromARGB(255, 237, 245, 176),
                     Color.fromARGB(255, 24, 23, 23),
                     Color.fromARGB(255, 18, 18, 18),
                ],
              )
            ),
            child: ListView(
              shrinkWrap: true, // ME CENTRA TODOS LOS ELEMENTOS DE LA LISTA
              children: state.roles != null
                  ? ( state.roles?.map(( Role role) {
                    return RolesItem(role);
                    }).toList()
                    ) as List<Widget>
                  : []
            ),
          );
        },
      ),
    );
  }
}
