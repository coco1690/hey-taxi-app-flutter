


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/usecase/auth/index.dart';
import 'package:hey_taxi_app/src/presentation/pages/roles/bloc/roles_event.dart';
import 'package:hey_taxi_app/src/presentation/pages/roles/bloc/roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  AuthUseCases? authUseCases;
  RolesBloc(AuthUseCases authUseCases) : super(const RolesState()) {

    on<GetRolesList>((event, emit) async {
     AuthResponseModel? authResponse = await authUseCases.getUserSession.run();
      emit(state.copyWith(
        roles: authResponse?.user.roles
      ));

    });
  }

}