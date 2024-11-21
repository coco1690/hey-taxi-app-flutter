import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {

  final String text;
  final void Function()? onPressed;
  final Color colorFondo;
  final Color colorLetra;

  const DefaultElevatedButton({

  super.key,
  required this.text, 
  required this.onPressed, 
  required this.colorFondo,
  required this.colorLetra,
  });

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom( backgroundColor: colorFondo ),
      child: Text( text, style: TextStyle( fontWeight: FontWeight.bold, color: colorLetra),)
    );
  }
}