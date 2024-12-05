import 'package:equatable/equatable.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';

class DriverHomeState extends Equatable {

  final User? user;
  final int pageIdex;

// ##### CONSTRUCTOR #####
  const DriverHomeState({
    this.user,
    this.pageIdex = 0
  });

// #### METODO COPYWITH ES EL QUE ME PERMITE CAMBIAR EL ESTADO ####
  DriverHomeState copyWith({
    User? user,
    int? pageIdex,
  }) {
    return DriverHomeState( pageIdex: pageIdex ?? this.pageIdex, user: user ?? this.user ); // si viene null, me toma el valor 0 que viene del constructor
  }

  @override
  List<Object?> get props => [ pageIdex, user ];

}