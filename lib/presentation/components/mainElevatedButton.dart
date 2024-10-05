import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

Widget mainElevatedButton(String text, VoidCallback onPressed) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: clr(1), padding: EdgeInsets.symmetric(vertical: 8)),
    onPressed: onPressed,
    child: Text(
      text,
      style:
          TextStyle(fontSize: 18, color: clr(0), fontWeight: FontWeight.bold),
    ),
  );
}
