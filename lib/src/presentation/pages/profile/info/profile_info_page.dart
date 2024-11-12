import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/profile/info/profile_info_content.dart';

import 'bloc/index.dart';

class ProfileInfoPage extends StatefulWidget {

  const ProfileInfoPage({super.key });

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  
  @override
  Widget build(BuildContext context) { // SEGUNDO EVENTTO EN DISPARARSE Y SE DISPARA CDA VEZ QUE HACEMOS COMAND + O SI CAMBIA EL ESTADO
  // print('PROFILEINFO PAGE METODO BUILD');
    return  Scaffold(
      body: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
      builder: (context, state) {
        return  ProfileInfoContent( state.user);
      },
    ));
  }
}
