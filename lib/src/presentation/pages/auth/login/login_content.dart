import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/login/bloc/login_bloc.dart';

import 'package:hey_taxi_app/src/presentation/pages/auth/login/bloc/login_event.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/login/bloc/login_state.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_elevatedbutton.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_textfield.dart';

class LoginContent extends StatelessWidget {

  final LoginState state;

  const LoginContent( this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: state.formKey,
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
    
          _imageLogin(context),
    
        
        
            Container( 
              margin: const EdgeInsets.only( left: 40, right: 40),
            
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      
                    const SizedBox( height: 50,),
                    const Text('Lets ride', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                    const Text('HeyTaxi', style: TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color:  Color.fromRGBO(243, 159, 90, 20),),),
                
                        
                  Container(
                    // color: Colors.amber,
                    margin: const EdgeInsets.only( top:230),
                           
                  
                      child: Column(
                      
                        children: [
                       
                    
                        DefaultTextField(
                          text: 'Email', 
                          icon: Icons.email, 
                          onChanged: (text) { 
                            context.read<LoginBloc>().add( EmailChanged(email: BlocFormItem(value: text)));
                           },
                           validator: (value) => state.email.error,
                          ),
                            
                        DefaultTextField(
                          text: 'Password', 
                          icon: Icons.lock_outline_rounded, 
                          obscureText: true,
                          onChanged: (text) { 
                            context.read<LoginBloc>().add( PasswordChanged(password: BlocFormItem(value: text)));
                            },
                          validator: (value) => state.password.error,
                          ),
                            
                    
                      Container(
                        
                          width: MediaQuery.of(context).size.width,
                          height: 48,          
                       
                          margin: const EdgeInsets.only( top: 30),
                    
                          child: DefaultElevatedButton(
                            text: 'SING IN', 
                            onPressed: (){
                               if (state.formKey!.currentState!.validate()){
                
                                   context.read<LoginBloc>().add(FormSubmit());
                                }
                                else{
                                  print('El Formulario no es Valido');
                                }
                              }, 
                            
                            colorFondo: const Color.fromARGB(255, 243, 159, 90,),
                            colorLetra: Colors.black
                          )
                          
                      ),
                      
                        const SizedBox( height: 20,),
                        const Text('¿You dont have an account?', style: TextStyle( fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold,),),
                    
                        Container(
                        
                          width: MediaQuery.of(context).size.width,
                          height: 48,          
                       
                          margin: const EdgeInsets.only( top: 20),
                    
                          child: DefaultElevatedButton(
                            text: 'REGISTER', 
                            onPressed: (){
                              Navigator.pushNamed(context, 'register');
                            }, 
                            colorFondo: const Color.fromARGB(255,	232,	188,	185,), 
                            colorLetra: Colors.black
                           )
                        
                          ),
                    
                        ]),
                     
                    )  
                               
                  ],
                ),
              ),
            ),
          
        ],
      ),
    );
  } 
}


  Widget _imageLogin(BuildContext context){
    return Image.asset(
      'assets/img/city.jpg',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit:BoxFit.cover,
      color: Colors.black54,
      colorBlendMode: BlendMode.darken  
  );
}

