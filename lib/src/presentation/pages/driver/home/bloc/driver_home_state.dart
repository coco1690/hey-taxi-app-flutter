import 'package:equatable/equatable.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';

class DriverHomeState extends Equatable {

  final User? user;
  final int pageIdex;
  final int? idDriver;

// ##### CONSTRUCTOR #####
  const DriverHomeState({
    this.user,
    this.pageIdex = 0,
    this.idDriver,
  });

// #### METODO COPYWITH ES EL QUE ME PERMITE CAMBIAR EL ESTADO ####
  DriverHomeState copyWith({
    User? user,
    int? pageIdex,
    int? idDriver,
  }) {
    return DriverHomeState( pageIdex: pageIdex ?? this.pageIdex, user: user ?? this.user, idDriver: idDriver ?? this.idDriver );
  }

  @override
  List<Object?> get props => [ pageIdex, user, idDriver ];

}