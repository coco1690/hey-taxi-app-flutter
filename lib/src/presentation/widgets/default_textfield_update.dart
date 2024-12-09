import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_taxi_app/src/presentation/pages/profile/update/bloc/index.dart';
import 'package:hey_taxi_app/src/presentation/utils/bloc_form_item.dart';

class DefaultTextFieldUpdate extends StatelessWidget {
  final Function(String text) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData label;
  final String? initialValue;
  final bool isNameField;

  const DefaultTextFieldUpdate(
      {super.key,
      required this.onChanged,
      this.obscureText = false,
      required this.label,
      this.validator,
      this.initialValue,
      required this.isNameField
      });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
      builder: (context, state) {
        final iconColor = isNameField ? state.nameIconColor : state.phoneIconColor;
        return TextFormField(
          cursorColor: Colors.amber,
          initialValue: initialValue,
          textAlign: TextAlign.center,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          obscureText: obscureText,
          onChanged: (text) {
            onChanged(text);
             if (isNameField) {
              context.read<ProfileUpdateBloc>().add(ProfileUpdateNameChanged(name: BlocFormItem(value: text)));
            } else {
              context.read<ProfileUpdateBloc>().add(ProfileUpdatePhoneChanged(phone: BlocFormItem(value: text)));
            }
          },
          validator: validator,
          decoration: InputDecoration(
              label: Icon(label, color: iconColor), 
              border: InputBorder.none, 
              isCollapsed: true
          ),
        );
      },
    );
  }
}
