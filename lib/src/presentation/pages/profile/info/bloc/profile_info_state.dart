import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';

class ProfileInfoState extends Equatable{

  final User? user;
  final BlocFormItem name;
  final BlocFormItem phone;
  final Resource? response;
  final GlobalKey<FormState>? formKey;


  // ##### CONSTRUCTOR #####
  const ProfileInfoState({ 
    this.user,
    this.name = const BlocFormItem( error: 'Ingresa el nombre'),
    this.phone = const BlocFormItem( error: 'ingresa el numero de telefono'),
    this.response,
    this.formKey, 
    });

  ProfileInfoState copyWith({
    User? user,
    BlocFormItem? name,
    BlocFormItem? phone,
    Resource? response,
    GlobalKey<FormState>? formKey,
  }){
    return ProfileInfoState(  
      user: user,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      response: response, 
      formKey: formKey
    );
  }

  @override
  List<Object?> get props => [ user, name, phone,response ];

}