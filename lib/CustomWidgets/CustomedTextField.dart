import 'package:flutter/material.dart';

class TextFieldCustomed extends StatelessWidget {
  const TextFieldCustomed(
      {super.key,
      required this.hint,
      required this.onChange,
      required this.secured});
  final String hint;
  final bool secured;
  // secured:false
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: secured,
      validator: (value) {
        if (value!.isEmpty) return 'Field is required';
      },
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: hint,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(25)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25))),
    );
  }
}
