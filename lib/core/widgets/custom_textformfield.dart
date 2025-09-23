import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextformfield extends StatelessWidget {

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validation;
  final bool? isObscureText;
  final String? obscuringCharacter;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final Function(String)? onChanged;
  
  const CustomTextformfield({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validation,
    this.isObscureText = false,
    this.obscuringCharacter = "*",
    this.hintText,
    this.hintStyle,
    this.labelStyle,
    this.textStyle,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyLarge,
      obscureText: isObscureText!,
      validator: validation,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // default line color
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2), // when focused
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        )
      )
    );
  }
  
}