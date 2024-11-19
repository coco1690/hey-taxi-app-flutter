
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/index.dart';
import 'package:hey_taxi_app/src/domain/usecase/user/user_use_cases.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';
import 'package:image_picker/image_picker.dart';

import 'index.dart';


class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {

  AuthUseCases authUseCases;
  UserUseCases userUseCases;
  final formKey = GlobalKey< FormState>();
  
ProfileUpdateBloc( this.userUseCases, this.authUseCases ):super(const ProfileUpdateState()){

 
  on<ProfileUpdateInitEvent>((event, emit) async {
      final initialName = event.user?.name ?? '';
      final initialPhone = event.user?.phone ?? '';
      emit(
        state.copyWith(
          id: event.user?.id,
          name: BlocFormItem( value: event.user?.name ?? ''),
          phone: BlocFormItem( value: event.user?.phone ?? ''),
          nameIconColor: initialName.isEmpty ? Colors.amber : Colors.grey,
          phoneIconColor: initialPhone.isEmpty ? Colors.amber : Colors.grey,
          formKey: formKey      
        ));
    });

  on<ProfileUpdateNameChanged>((event, emit ){
     final isNameEmpty = event.name.value.isEmpty;
      emit( state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value.isEmpty ? 'ingresa el nombre' : null
        ),
        nameIconColor: isNameEmpty ? Colors.amber : Colors.grey, // Cambia el color del ícono
        formKey: formKey
        ));
    });

  on<ProfileUpdatePhoneChanged>((event, emit){
    final isPhoneEmpty = event.phone.value.isEmpty;
      emit( state.copyWith(
        phone: BlocFormItem(
          value: event.phone.value,
          error: event.phone.value.isEmpty ? 'ingresa el numero de telefono' : null
        ),
        phoneIconColor: isPhoneEmpty ? Colors.amber : Colors.grey, 
        formKey: formKey 
      ));
    });

  on<ProfileFormSubmitUpdate>((event, emit) async {
      print('Name:     ${ state.name.value     }');
      print('Phone:    ${ state.phone.value    }');
      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey, // parametro formkey me mantiene el estado del formulario
        )
      );
      Resource response = await userUseCases.updateUser.run( state.id, state.toUser(), state.image );
      emit(
        state.copyWith(
          response: response,
          formKey: formKey,
        )
      );
    });

  on<UpdateUserSession>((event, emit) async {
      AuthResponseModel  authResponseModel = await authUseCases.getUserSession.run();
      authResponseModel.user.name = event.user.name;
      authResponseModel.user.phone = event.user.phone;
      authResponseModel.user.image = event.user.image;
      await authUseCases.saveUserSession.run(authResponseModel);
    });

  on<PickImage>((event, emit) async {
    final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) { // SI EL USUARIO SELECCIONO UNA IMAGEN
        emit(
           state.copyWith(
            image: File(image.path),
            formKey: formKey
          )
        );
      }
  });

  on<TakePhoto>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) { // SI EL USUARIO SELECCIONO UNA IMAGEN
        emit(
           state.copyWith(
            image: File(image.path),
            formKey: formKey
          )
        );
      }
    });

  }
}