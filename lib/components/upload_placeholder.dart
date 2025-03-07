import 'package:flutter/material.dart';

Widget uploadPlaceholder() {
  return Container(
    height: 150,
    width: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.camera_alt, color: Colors.grey),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Take a Picture of your Visit",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
              fontFamily: 'Lato',
            ),
          ),
        ),
      ],
    ),
  );
}
