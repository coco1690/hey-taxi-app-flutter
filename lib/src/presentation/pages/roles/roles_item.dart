
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hey_taxi_app/src/domain/models/role.dart';


class RolesItem extends StatelessWidget {

  final Role role;

  const RolesItem( this.role, {super.key} );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(context, role.route , (route) => false);
      },
      child: Column(
        children: [

          Container(
            margin: const EdgeInsets.only( bottom: 10, top: 10),
            height: 150,
            child: AspectRatio(
              aspectRatio: 1,
            child: ClipOval(
              child:( role.image != null && role.image!.isNotEmpty )
              ? CachedNetworkImage(
                imageUrl: role.image ?? '',
                placeholder: (context, url ) => Image.asset('assets/img/user_image.png'),
                errorWidget: (context, url, error) => Image.asset('assets/img/user_menu.png'),
                fit: BoxFit.cover,
              )
              : Image.asset(
                'assets/img/user_image.png',
                fit: BoxFit.cover,
                ),
                
            )
          ),
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