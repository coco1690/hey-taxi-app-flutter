import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/register/register_content.dart';
import 'bloc/index.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            final response = state.response;
              if( response is ErrorData){
                      _messageSanckToastError(context, response);
                      print('Error Data en register_page: ${response.message}');
                    
                  }
                  else if( response is Succes){
                      _messageSanckToastSucces(context);
                      final authResponseModel = response.data as AuthResponseModel; // casteo la data de response.data
                      context.read<RegisterBloc>().add(FormReset()); // REINICIO EL FORMULARIO
                      context.read<RegisterBloc>().add( SaveUserSession ( authResponseModel: authResponseModel ) );

                      Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
                      // print('Succes Data: ${response.data}');
                  }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return RegisterContent(state);
            },
          ),
        ),
      ),
    );
  }
}


Widget _messageSanckToastSucces(BuildContext context){
      const stack =  SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
        title: 'Welcome!',
        message:' Registro Exitoso!!!',
        contentType: ContentType.success,
       
      ),
  );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(stack);
    return stack;
}

 Widget _messageSanckToastError( BuildContext context, response){
      final stack =  SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
        title: 'ERROR!',
        message:'${response.message}',
        contentType: ContentType.failure,
      ),
  );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(stack);
    return stack;
}