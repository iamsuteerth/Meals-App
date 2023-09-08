import 'package:flutter/material.dart';

class MealItemMetaData extends StatelessWidget {
  const MealItemMetaData({
    super.key,
    required this.icon,
    required this.label,
    required this.isVegetarian,
  });
  final IconData icon;
  final String label;
  final bool isVegetarian;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.white,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
      ],
    );
  }
}
