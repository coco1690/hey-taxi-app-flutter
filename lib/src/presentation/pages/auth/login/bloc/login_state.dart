import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';

// se anotan las variables que van a acambiar de estado
class LoginState extends Equatable {
  
  final BlocFormItem email;
  final BlocFormItem password;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const LoginState({
   
    this.email = const BlocFormItem( error: 'Ingresa el Email'),
    this.password = const BlocFormItem(error: 'Ingresa el Password'),
    this.response,
    this.formKey

  });

  LoginState copyWith({
    
    BlocFormItem? email,
    BlocFormItem? password,
    Resource? response,
    GlobalKey<FormState>? formKey,


  }) {
    return LoginState(
      
      email: email ?? this.email,
      password: password ?? this.password,
      response: response,
      formKey: formKey
    );
  }

    @override
    List<Object?> get props => [email, password, response];
}