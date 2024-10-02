import 'package:flutter/material.dart';
import 'package:lati_game_app/helpers/const.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.label, required this.onPressed});
  final String label;

  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(blueColor),
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
