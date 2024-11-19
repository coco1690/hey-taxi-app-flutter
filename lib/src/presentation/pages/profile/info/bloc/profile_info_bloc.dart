import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/index.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';
import 'index.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {

  AuthUseCases authUseCases;
  final formKey = GlobalKey< FormState>();
  
ProfileInfoBloc( this.authUseCases ):super(const ProfileInfoState()){

  on<ProfileInfoUpdateInitEvent>((event, emit) async {
      emit(
        state.copyWith(
          name: BlocFormItem( value: event.user?.name ?? ''),
          phone: BlocFormItem( value: event.user?.phone ?? ''),
          formKey: formKey      
        ));
    });

  on<ProfileInfoNameChanged>((event, emit){
      emit( state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value.isEmpty ? 'ingresa el nombre' : null
        ),
        formKey: formKey  ));
    });

  on<ProfileInfoPhoneChanged>((event, emit){
      emit( state.copyWith(
        phone: BlocFormItem(
          value: event.phone.value,
          error: event.phone.value.isEmpty ? 'ingresa el numero de telefono' : null
        ),
        formKey: formKey  ));
    });

  on<ProfileInfoFormSubmitUpdate>((event, emit) {
      print('Name:     ${ state.name.value     }');
      print('Phone:    ${ state.phone.value    }');
    });

  on<GetUserInfo>((event, emit) async {
      AuthResponseModel authResponseModel = await authUseCases.getUserSession.run();
      emit(state.copyWith( user: authResponseModel.user));
  });
}

 
}