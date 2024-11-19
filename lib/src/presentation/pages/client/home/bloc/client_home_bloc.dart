import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/auth_use_cases.dart';
import 'index.dart';


class ClientHomeBloc extends Bloc< ClientHomeEvent, ClientHomeState> {

  AuthUseCases authUseCases;
  //#### CONSTRUCTOR ####
  ClientHomeBloc( this.authUseCases ):super( const ClientHomeState()) {

    on<ChangeDrawerPage>((event, emit) {
      emit( state.copyWith( pageIdex: event.pageIdex ) );
    });

    on<Logout>((event, emit) async {
      await authUseCases.logout.run();      
    });

     on<GetUserInfoHome>((event, emit) async {
      AuthResponseModel authResponseModel = await authUseCases.getUserSession.run();
      emit(state.copyWith( user: authResponseModel.user));
  });
  }

}