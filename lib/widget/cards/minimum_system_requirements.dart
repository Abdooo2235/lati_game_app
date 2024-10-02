import 'package:flutter/material.dart';
import 'package:lati_game_app/models/detailed_game_model.dart';

class MinimumSystemRequirementsCard extends StatelessWidget {
  const MinimumSystemRequirementsCard(
      {super.key, required this.minimumSystemRequirementsModel});

  final MinimumSystemRequirementsModel minimumSystemRequirementsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Minimum System Requirements",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "OS: ${minimumSystemRequirementsModel.os}",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Text(
          "MEMORY: ${minimumSystemRequirementsModel.memory}",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Text(
          "PROCESSOR: ${minimumSystemRequirementsModel.processor}",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Text(
          "GRAPHICS: ${minimumSystemRequirementsModel.graphics}",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Text(
          "STORAGE: ${minimumSystemRequirementsModel.storage}",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}