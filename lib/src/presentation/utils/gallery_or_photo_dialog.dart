

import 'package:flutter/material.dart';

galleryOrPhotoDialog( BuildContext context, Function() pickImage, Function() takePhoto){
  
   return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecciona una opción'),
          content: const Text('¿Deseas subir una foto o seleccionar una galería?'),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                pickImage();
              },
              child: const Text('Galería'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                takePhoto();
              },
              child: const Text('Foto'),
            ),
          ],
        );
      },
    );
  
}