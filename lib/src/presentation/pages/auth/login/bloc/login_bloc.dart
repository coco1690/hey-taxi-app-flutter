import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/auth_use_cases.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';
import 'index.dart';

class LoginBloc extends Bloc< LoginEvent, LoginState > {


  AuthUseCases authUseCases;
  final formKey = GlobalKey< FormState>();

  LoginBloc( this.authUseCases ):super( const LoginState() ){

    on<LoginInitEvent> ( ( event, emit ) async {
      AuthResponseModel? authResponseModel =  await authUseCases.getUserSession.run();
      print( 'Auth response Session in login bloc: ${authResponseModel?.toJson()}' );
      emit(state.copyWith( formKey: formKey ) );

      //  ######## si tengo datos de User en sesion me cambia el estado ######################
      //  ######## a la hora de recargar no me devuelve al Login y mantengo el Home  #########
      
      if (authResponseModel != null) {
        emit(
          state.copyWith(
            response: Succes(authResponseModel),
            formKey: formKey
          )
        );
      }
    });

    on<SaveUserSession>( ( event, emit ) async{
      await authUseCases.saveUserSession.run(event.authResponseModel);
    });
    
    on<EmailChanged>   ( ( event, emit ) {
      //LO QUE EL USUARIO ESCRIBE
      emit( state.copyWith( 
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isEmpty ? 'Ingresa el Email' : null,
        ), 
        formKey: formKey  ) );
    });

    on<PasswordChanged>( ( event, emit ) {
      emit( state.copyWith( 
        password: BlocFormItem(
          value: event.password.value,
          error: 
            event.password.value.isEmpty 
            ? 'Ingresa el Password' 
            : event.password.value.length < 6 
              ? 'Minimo 6 caracteres' 
              : null,
        ),
        formKey: formKey ) );
    });

    on<FormSubmit>( ( event, emit ) async {
      print('Email: ${ state.email.value }');
      print('Password: ${ state.password.value }');
      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey,
        )
      );
      Resource response =await authUseCases.login.run( state.email.value, state.password.value );
      emit(
        state.copyWith(
          response: response,
          formKey: formKey,
        )
      );
    });

  }
}