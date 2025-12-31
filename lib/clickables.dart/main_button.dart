import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.btnColor,
      required this.txtColor});
  final String label;

  final Function onPressed;
  final Color btnColor;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(btnColor),
        ),
        onPressed: () {
          onPressed();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Text(label),
        ));
  }
}
