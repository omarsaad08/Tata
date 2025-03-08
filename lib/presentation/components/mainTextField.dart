import 'package:flutter/material.dart';
import 'package:tata/presentation/components/theme.dart';

Widget mainTextField(
    TextEditingController controller, String label, Icon icon) {
  return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          prefixIcon: icon,
          prefixIconColor: clr(1)));
}
