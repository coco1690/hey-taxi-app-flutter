import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';
// import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';

class ProfileUpdateState extends Equatable{

  final int id;
  final BlocFormItem name;
  final BlocFormItem phone;
  final Color nameIconColor;
  final Color phoneIconColor;
  final File? image;
  final Resource? response;
  final GlobalKey<FormState>? formKey;


  // ##### CONSTRUCTOR #####
  const ProfileUpdateState({ 
    this.id = 0,
    this.name = const BlocFormItem( error: 'Ingresa el nombre'),
    this.phone = const BlocFormItem( error: 'ingresa el numero de telefono'),
    this.nameIconColor = Colors.amber, // Color inicial para el ícono de nombre
    this.phoneIconColor = Colors.amber, // Color inicial para el ícono de teléfono
    this.image,
    this.response,
    this.formKey, 
    });

    toUser() => User(
    id: id,
    name: name.value, 
    phone: phone.value
  );

  ProfileUpdateState copyWith({
    int? id,
    BlocFormItem? name,
    BlocFormItem? phone,
    Color? nameIconColor,
    Color? phoneIconColor,
    File? image,
    Resource? response,
    GlobalKey<FormState>? formKey,
  }){
    return ProfileUpdateState(  
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      nameIconColor: nameIconColor ?? this.nameIconColor,
      phoneIconColor: phoneIconColor ?? this.phoneIconColor,
      image: image ?? this.image,
      response: response, 
      formKey: formKey
    );
  }

  @override
  List<Object?> get props => [id, name, phone, image, response, nameIconColor, phoneIconColor, ];

}