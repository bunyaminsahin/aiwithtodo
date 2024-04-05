import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  String? Function(String?)? validator;
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final TextInputType keyboardType;
  final AutovalidateMode? autovalidateMode;

  MyTextFormField({
    super.key,
    required this.validator,
    required this.focusNode,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.keyboardType,
    this.autovalidateMode,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode:
          widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
      validator: widget.validator, //
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      focusNode: widget.focusNode, //
      controller: widget.controller, //
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, //
            color: const Color.fromARGB(255, 255, 255, 255)),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.white),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      keyboardType: widget.keyboardType, //
    );
  }
}
