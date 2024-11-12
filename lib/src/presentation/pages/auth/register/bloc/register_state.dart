import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';

class RegisterState extends Equatable {

  final BlocFormItem name;
  final BlocFormItem phone;
  final BlocFormItem email;
  final BlocFormItem password;
  final Resource? response;
  final GlobalKey<FormState>? formKey;
  
  const RegisterState({

    this.name     = const BlocFormItem( error: 'Ingresa el nombre'),
    this.phone    = const BlocFormItem( error: 'Ingresa el numero de telefono'),
    this.email    = const BlocFormItem( error: 'Ingresa el Email'),
    this.password = const BlocFormItem(error: 'Ingresa el Password'),
    this.response,
    this.formKey

  });

  toUser() => User(
    name: name.value, 
    phone: phone.value, 
    email: email.value,
    password: password.value
  );

  RegisterState copyWith({

    BlocFormItem? name,
    BlocFormItem? phone,
    BlocFormItem? email,
    BlocFormItem? password,
    Resource? response,
    GlobalKey<FormState>? formKey,

  }) {
    return RegisterState(

      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      response: response,
      formKey: formKey
    );
  }

  @override
    List<Object?> get props => [name, phone, email, password, response];

}