import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  final String text;
  final Future Function()? onTap;
  double currentWidth;
  AuthButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.currentWidth,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              //gradient: LinearGradient(colors: MyGlassColors),
              color: Colors.white.withOpacity(0.25),
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            width: widget.currentWidth < 400 ? widget.currentWidth - 20 : 400,
            height: 58,
            alignment: Alignment.center,
            child: Text(
              widget.text,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }
}
