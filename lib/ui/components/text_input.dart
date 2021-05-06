import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key key,
    @required this.inputError,
    this.title,
    this.obscureText,
    this.validator,
    this.controller,
  }) : super(key: key);

  final bool inputError;
  final String title;
  final bool obscureText;
  final String Function(String) validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        hintStyle: TextStyle(color: Colors.black26),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: inputError
              ? BorderSide(color: Colors.red)
              : BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: inputError
              ? BorderSide(color: Colors.red)
              : BorderSide(color: Colors.transparent),
        ),
        fillColor: Color(0xffF6F6F8),
        filled: true,
      ),
    );
  }
}
