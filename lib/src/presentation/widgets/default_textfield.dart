import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {

  final String text;
  final IconData? icon;
  final Function(String text) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;

  const DefaultTextField({
     super.key, 
     required this.text,
     this.icon,
     required this.onChanged,
     this.obscureText = false,
     this.validator
    });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: obscureText,
      onChanged: (text) {
        onChanged(text);
      } ,
      validator: validator,
      decoration:  InputDecoration(

          label: Text( text,  style:  const TextStyle( color: Colors.white)),
          prefixIcon: Icon(icon, color: const Color.fromARGB(255, 243, 159, 90,), ),
          errorStyle: const TextStyle(color: Colors.amber),

          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
        ),
          focusedBorder: const UnderlineInputBorder(
           borderSide: BorderSide(color: Colors.white)
        )
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}