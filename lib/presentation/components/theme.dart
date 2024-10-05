import 'package:flutter/material.dart';

Color clr(int colorNum) {
  switch (colorNum) {
    case 0:
      return Colors.white;
    case 1:
      return Color(0xffE26868);
    case 2:
      return Color(0xffFF8787);
    case 3:
      return Color(0xfEDEDED);
    case 4:
      return Color(0xffD8D9CF);
    case 5:
      return Color(0xffffffff);
  }
  return Colors.black;
}
// fec81e