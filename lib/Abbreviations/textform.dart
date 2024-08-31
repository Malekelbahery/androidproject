import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextEditingController controll;
  final String text;
  final String? Function(String?)? validator;
  final TextInputType type;
  final bool passwordtf;

  const CustomText(
      {super.key,
      required this.controll,
      required this.text,
      required this.validator,
      required this.type,
      required this.passwordtf});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: passwordtf,
      keyboardType: type,
      controller: controll,
      decoration: InputDecoration(
        hintText: text,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: Colors.black, width: 2.5)),
      ),
    );
  }
}
