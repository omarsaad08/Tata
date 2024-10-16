import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

Widget mainElevatedButton(String text, VoidCallback onPressed, {Color? color}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: color == null ? clr(1) : color,
        padding: EdgeInsets.symmetric(vertical: 8)),
    onPressed: onPressed,
    child: Text(
      text,
      style:
          TextStyle(fontSize: 18, color: clr(0), fontWeight: FontWeight.bold),
    ),
  );
}
