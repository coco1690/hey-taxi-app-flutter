import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/auth_response.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/login/login_content.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../../bloc_socketIo/index.dart';
import 'bloc/index.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                   final response = state.response;
                     if( response is ErrorData){

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(response.message),
                      //     behavior: SnackBarBehavior.floating ,
                      //   )
                      // );
                      _messageSanckToastError(context, response);
                       print('Error Data en login Page: ${response.message}');
                  }
                  else if( response is Succes){
                      // _messageSanckToastSucces(context);
                      print('Succes Data in login page: ${response.data}');
                      final authResponseModel = response.data as AuthResponseModel; // casteo la data de response.data
                      context.read<LoginBloc>().add( SaveUserSession ( authResponseModel: authResponseModel ) );
                      context.read<BlocSocketIO>().add(ConnectSocketIo());
                      if( authResponseModel.user.roles!.length > 1 ) {
                        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
                      } else{
                        Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
                      }
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return LoginContent(state);
                  },
                ),
              ),
          ),
      ),
      ]
    );
  }
}

//  Widget _messageToastError(context, response){
//       final b =  MaterialBanner(
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       forceActionsBelow: true,
//       content:  AwesomeSnackbarContent(
//         title: 'Oh Hey!!',
//         message: '${response.message}',
//         contentType: ContentType.failure,
//         inMaterialBanner: true,
//     ),
//       actions: const [SizedBox.shrink()],
//   );

//      ScaffoldMessenger.of(context)
//     ..hideCurrentMaterialBanner()
//     ..showMaterialBanner(b);
//     return b;
// }

 Widget _messageSanckToastSucces(BuildContext context){
      const snack =  SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
        title: 'Welcome!',
        message:' successful login!!!',
        contentType: ContentType.success,
       
      ),
  );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snack);
    return snack;
}

 Widget _messageSanckToastError(BuildContext context, response){
      final s =  SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
        title: 'FAILURE!',
        message:'${response.message}',
        contentType: ContentType.failure,
      ),
  );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(s);
    return s;
}
