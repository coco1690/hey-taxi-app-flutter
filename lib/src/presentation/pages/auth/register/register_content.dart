import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/register/bloc/register_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/register/bloc/register_event.dart';
import 'package:hey_taxi_app/src/presentation/pages/auth/register/bloc/register_state.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_elevatedbutton.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_textfield.dart';

class RegisterContent extends StatelessWidget {

  final RegisterState state;

  const RegisterContent( this.state,{super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
       fit: StackFit.loose,
       alignment: Alignment.center,
        children: [

          _imageRegister(context),
          
      
          Container( 
            margin: const EdgeInsets.only( left: 40, right: 40),
          
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
                  const SizedBox( height: 50,),
                  const Text('Lets ride', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                  const Text('HeyTaxi', style: TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 243, 159, 90,),),),
                  const Text('Register', style: TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),),
              
                    
                Container(
            
                  margin: const EdgeInsets.only( top:150),
                   
                  child: Column(
                    children: [
            
                    DefaultTextField(
                      text: 'Name', 
                      icon: Icons.person, 
                      onChanged: (text) { 
                        context.read<RegisterBloc>().add( NameRegisterChanged(name: BlocFormItem(value: text)));
                       },
                      validator: (value) => state.name.error,
                    ), 
    
                    DefaultTextField(
                      text: 'Phone', 
                      icon: Icons.phone_android_outlined, 
                      onChanged: (text) { 
                        context.read<RegisterBloc>().add( PhoneRegisterChanged(phone: BlocFormItem(value: text)));
                       },
                       validator: (value) => state.phone.error,
                    ),  
    
                    DefaultTextField(
                      text: 'Email', 
                      icon: Icons.email, 
                      onChanged: (String text) { 
                        context.read<RegisterBloc>().add( EmailRegisterChanged(email: BlocFormItem(value: text)));
                       },
                      validator: (value) => state.email.error,
                    ),
    
                    DefaultTextField(
                      text: 'Password', 
                      icon: Icons.lock_outline_rounded, 
                      onChanged: (String text) { 
                        context.read<RegisterBloc>().add( PasswordRegisterChanged(password: BlocFormItem(value: text)));
                       },
                      validator: (value) => state.password.error,
                    ),
                                  
                    const SizedBox( height: 20,),
                 
            
                    Container(
                    
                      width: MediaQuery.of(context).size.width,
                      height: 48,          
                   
                      margin: const EdgeInsets.only( top: 20),
            
                      child: DefaultElevatedButton(
                        text: 'REGISTER', 
                        onPressed: () {
                           if (state.formKey!.currentState!.validate()){
                            
                            context.read<RegisterBloc>().add(FormSubmitRegister());
                            context.read<RegisterBloc>().add(FormReset());
                          }  else{
                                  print('El Formulario de registro no es Valido');
                          }
        
                        }, 
                        colorFondo: const Color.fromARGB(255, 243, 159, 90,), 
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

Widget _imageRegister(BuildContext context){
  return Image.asset(
   'assets/img/background1.jpg',
   width: MediaQuery.of(context).size.width,
   height: MediaQuery.of(context).size.height,
   fit:BoxFit.cover,
   color: Colors.black54,
   colorBlendMode: BlendMode.darken,
  );
}