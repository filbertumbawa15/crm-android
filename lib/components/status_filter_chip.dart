import 'package:flutter/material.dart';

class StatusFilterChip extends StatelessWidget {
  final String label;
  final Color color;
  const StatusFilterChip({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label,
          style: const TextStyle(fontFamily: 'Lato', color: Colors.white)),
      backgroundColor: color,
    );
  }
}
