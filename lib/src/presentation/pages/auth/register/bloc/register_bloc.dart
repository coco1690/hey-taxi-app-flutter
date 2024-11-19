import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/auth_use_cases.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';
import 'index.dart';

class RegisterBloc extends Bloc< RegisterEvent, RegisterState > {

  AuthUseCases authUseCases;
  final formKey = GlobalKey< FormState>();

  RegisterBloc( this.authUseCases ):super( const RegisterState()){

    on<RegisterInitEvent>((event, emit) async {
      emit(state.copyWith(formKey: formKey));
    });

    on<SaveUserSession>( ( event, emit ) async{
      await authUseCases.saveUserSession.run(event.authResponseModel);
    });

    on<NameRegisterChanged>((event, emit){
      emit( state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value.isEmpty ? 'ingresa el nombre' : null
        ),
        formKey: formKey  ));
    });

    on<PhoneRegisterChanged>((event, emit){
      emit( state.copyWith(
        phone: BlocFormItem(
          value: event.phone.value,
          error: event.phone.value.isEmpty ? 'ingresa el numero de telefono' : null
        ),
        formKey: formKey  ));
    });

    on<EmailRegisterChanged>((event, emit) {
      //LO QUE EL USUARIO ESCRIBE
      emit(state.copyWith( 
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isEmpty ? 'Ingresa el Email' : null,
        ), 
        formKey:formKey  ));
    });

    on<PasswordRegisterChanged>((event, emit) {
      emit(state.copyWith( 
        password: BlocFormItem(
          value: event.password.value,
          error: 
            event.password.value.isEmpty 
            ? 'Ingresa el Password' 
            : event.password.value.length < 6 
              ? 'Minimo 6 caracteres' 
              : null,
        ),
        formKey: formKey ));
    });

    on<FormSubmitRegister>((event, emit) async {
      print('Name:     ${ state.name.value     }');
      print('Phone:    ${ state.phone.value    }');
      print('Email:    ${ state.email.value    }');
      print('Password: ${ state.password.value }');
     

      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey, // parametro formkey me mantiene el estado del formulario
        )
      );

      Resource response = await authUseCases.register.run( state.toUser() );
      emit(
        state.copyWith(
          response: response,
          formKey: formKey,
        )
      );

    });

    on<FormReset>((event, emit) {
      state.formKey?.currentState?.reset();
    });

  }

}