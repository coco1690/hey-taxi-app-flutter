import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/auth_use_cases.dart';
import 'index.dart';


class DriverHomeBloc extends Bloc< DriverHomeEvent, DriverHomeState> {

  AuthUseCases authUseCases;
  //#### CONSTRUCTOR ####
  DriverHomeBloc( this.authUseCases ):super( const DriverHomeState()) {

    on<ChangeDrawerDriverPage>((event, emit) {
      emit( state.copyWith( pageIdex: event.pageIdex ) );
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