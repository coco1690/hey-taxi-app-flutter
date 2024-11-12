import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/pages/client/home/bloc/index.dart';
import 'package:hey_taxi_app/src/presentation/pages/profile/info/bloc/index.dart';
import 'package:hey_taxi_app/src/presentation/pages/profile/update/profile_update_content.dart';
import 'bloc/index.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  User? user;

  @override
  void initState() {
    // PRIMER EVENTO EN DISPARERSE Y SE DISPARA UNA SOLA VEZ
    super.initState();
    print('PROFILE UPDATE PAGE METODO INITSTATE');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print('PROFILE UPDATE PAGE METODO STATE BINDING');
      context.read<ProfileUpdateBloc>().add(ProfileUpdateInitEvent(user: user));
    });
  }

  @override
  Widget build(BuildContext context) {
    print('PROFILE UPDATE PAGE METODO BUILD');
    user = ModalRoute.of(context)?.settings.arguments as User;
    return Scaffold(
      body: BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
        listener: (context, state) {
          final  response = state.response;
          if( response is ErrorData){
            _messageSanckToastError(context, response);
            print('Error Data en profile_update_page: ${response.message}');
          }
          else if( response is Succes){
            User user = response.data as User;
            _messageSanckToastSucces(context); 
            context.read<ProfileUpdateBloc>().add(UpdateUserSession(user: user));
            Future.delayed(const Duration(seconds: 1), () {
              context.read<ProfileInfoBloc>().add(GetUserInfo());
              context.read<ClientHomeBloc>().add(GetUserInfoHome());
            });
          }
        },
        child: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
          builder: (context, state) {
            return ProfileUpdateContent(user, state);
          }, 
        ),
      ),
    );
  }
}



Widget _messageSanckToastSucces(BuildContext context){
      const snack =  SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
        title: 'SUCCESS!',
        message:' Usuario Actualizado!!!',
        contentType: ContentType.success,
       
      ),
  );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snack);
    return snack;
}

 Widget _messageSanckToastError(BuildContext context, response){
      final s =  SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
        title: 'FAILURE!',
        message:'${response.message}',
        contentType: ContentType.failure,
      ),
  );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(s);
    return s;
}
