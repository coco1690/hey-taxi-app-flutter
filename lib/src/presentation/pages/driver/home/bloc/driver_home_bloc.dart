import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/auth_use_cases.dart';
import 'package:hey_taxi_app/src/domain/usecase/driver_position/index.dart';
import 'index.dart';


class DriverHomeBloc extends Bloc< DriverHomeEvent, DriverHomeState> {

  final AuthUseCases authUseCases;
  final DriverPositionUseCases driverPositionUseCases;

  //#### CONSTRUCTOR ####
  DriverHomeBloc( this.authUseCases, this.driverPositionUseCases ) : super(const DriverHomeState()){

    on<ChangeDrawerDriverPage>((event, emit) {
      emit( state.copyWith( pageIdex: event.pageIdex ) );
    });

    on<DeleteLocationData>((event, emit) async {
      await driverPositionUseCases.deleteDriverPosition.run(event.idDriver);
   });

    on<Logout>((event, emit) async {
      await authUseCases.logout.run();      
    });

     on<GetUserInfoDriverHome>((event, emit) async {
      AuthResponseModel authResponseModel = await authUseCases.getUserSession.run();
      emit(state.copyWith( user: authResponseModel.user));
  });
  }

}