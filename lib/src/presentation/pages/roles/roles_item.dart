
import 'package:flutter/material.dart';
import 'package:hey_taxi_app/src/domain/models/role.dart';

class RolesItem extends StatelessWidget {

  final Role role;

  const RolesItem( this.role, {super.key} );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
          context, 
          role.route , 
          (route) => false,
          arguments: role,
          );
      },
      child: Column(
        children: [
       
          Container(
            height: 150,
            margin: EdgeInsets.only( bottom: 10, top: 15),
            child: FadeInImage(
              image: NetworkImage(role.image ?? ''),
              fit: BoxFit.contain,
              fadeInDuration: const Duration(milliseconds: 1),
              placeholder: const AssetImage('assets/img/no-image.png'), 
            )
          ),

          Text(
            role.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          )
        ]
      ),
    );
  }
} 