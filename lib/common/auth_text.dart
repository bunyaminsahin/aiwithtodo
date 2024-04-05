import 'package:flutter/material.dart';

class AuthText extends StatelessWidget {
  final String text;
  const AuthText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
    );
  }
}
