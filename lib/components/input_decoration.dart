import 'package:flutter/material.dart';

InputDecoration borderinputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8), // Square-like corners
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:
          const BorderSide(color: Colors.purple, width: 2), // Primary color
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
  );
}
