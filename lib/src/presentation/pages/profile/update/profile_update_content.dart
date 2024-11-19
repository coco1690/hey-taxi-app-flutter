import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/domain/models/user.dart';
import 'package:hey_taxi_app/src/presentation/pages/profile/update/bloc/index.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';
import 'package:hey_taxi_app/src/presentation/utils/gallery_or_photo_dialog.dart';
import 'package:hey_taxi_app/src/presentation/widgets/default_textfield_update.dart';



class ProfileUpdateContent extends StatelessWidget {

final User? user;
final ProfileUpdateState state;
 
const ProfileUpdateContent(this.user, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
   
    return Form(
      key: state.formKey,
      child: Stack(
        children: [
          Column(
            children: [
              _headerProfile(context),
              const Spacer(),
    
              _actionButtonsProfile( context, 'Actualizar', Icons.update, 
                (){
                    if (state.formKey!.currentState != null) {
                    if (state.formKey!.currentState!.validate()) {
                      return context.read<ProfileUpdateBloc>().add( ProfileFormSubmitUpdate());          
                    }
                  } else {
                      return context.read<ProfileUpdateBloc>().add( ProfileFormSubmitUpdate());        
                  }  
                }
              ),
    
              const SizedBox(height: 90,)
              
            ],
          ),
               _cardInfoUser(context, user, state),
        ],
      ),
    );
  }
}

Widget _actionButtonsProfile(BuildContext context, String option, IconData icon, Function() function ){
  return 
  GestureDetector(
   onTap: () {
     function();
   },
    child: ListTile(
      title: Text(option),
      leading: Icon(icon),
    ),
  );
}

Widget _headerProfile(BuildContext context){
  return Column(
      children: [
        Container(
          padding: const EdgeInsets.only( top: 100),
          alignment: Alignment.topCenter,
          height: MediaQuery.of(context).size.height * 0.35,
          width:  MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            
            color: Colors.blueGrey.shade900,
         ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Container(
                margin: const EdgeInsets.only(right: 30, left: 20),
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                    icon: const Icon(Icons.arrow_back_ios_new_rounded), 
                    color: Colors.amber, 
                    iconSize: 30,
                  )
                ),
               
               Container(
                margin: const EdgeInsets.only( left: 50 ),
                child: const Text('EDITAR PERFIL', style:TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
            ],
          ),
        ),    
      ],
    );
}

Widget _cardInfoUser( BuildContext context, User? user, ProfileUpdateState state){
  return Container(
    margin: const EdgeInsets.only( left: 20, right: 20, top: 210),
    width: MediaQuery.of(context).size.width,
    height: 360,
    child: Card(
      color: Colors.blueGrey[800],
      child: Column(
        children: [
          Stack(
            children: [  GestureDetector(
              onTap: (){
                galleryOrPhotoDialog(
                  context, 
                  () { context.read<ProfileUpdateBloc>().add(PickImage()); }, 
                  () { context.read<ProfileUpdateBloc>().add(TakePhoto()); }
                );
              },
              child: Container(     
                margin: const EdgeInsets.only( top: 20, bottom: 35),
                child: SizedBox(
                  width: 115,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipOval(
                      child: state.image != null 
                      ? Image.file(state.image!, fit: BoxFit.cover )
                      : user != null && user.image != null && user.image!.isNotEmpty 
                      ?CachedNetworkImage(
                      imageUrl: user.image!,
                      placeholder: (context, url) => Image.asset('assets/img/user_image.png'),
                      errorWidget: (context, url, error) => Image.asset('assets/img/user_image.png'),
                      fit: BoxFit.cover,
                  )
                      : Image.asset(
                         'assets/img/user_image.png',
                          fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only( top: 100, left: 80),
              child:  const Icon(Icons.add_a_photo_rounded, color: Colors.amberAccent, size: 30,)
              ),
        ]
      ),
        

          Container(
            margin: const EdgeInsets.only(  bottom: 15),
            width: 170,
              child: DefaultTextFieldUpdate(
                isNameField: true,
                label: Icons.edit,
                initialValue: user?.name ?? '',
                onChanged: (text){
                  context.read<ProfileUpdateBloc>().add(ProfileUpdateNameChanged( name:BlocFormItem ( value: text)));
                }, 
                validator: (value) => state.name.error 
                ),
          ),
        
          Text( user?.email ?? '', style: const TextStyle( color: Colors.white54) ),
          
          Container(
              width: 170,
              margin: const EdgeInsets.only(  top: 15),
                child: DefaultTextFieldUpdate(
                  isNameField: false,
                  label: Icons.edit,
                  initialValue: user?.phone ?? '',
                  onChanged: (text){
                    context.read<ProfileUpdateBloc>().add(ProfileUpdatePhoneChanged( phone:BlocFormItem ( value: text)));
                  },
                  validator: (value) => state.phone.error           
                ),
            ),
        ],
      ),
    ),
  );
}