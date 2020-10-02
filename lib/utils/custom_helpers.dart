import 'package:flutter/material.dart';

class CustomHelpers {
  static const Color customAmber = Color(0xFFFCD228);

  static const List<String> backgrounds = [
    "assets/backgrounds/1.jpg",
    "assets/backgrounds/2.jpg",
    "assets/backgrounds/3.jpg",
    "assets/backgrounds/4.jpg",
    "assets/backgrounds/5.jpg",
    "assets/backgrounds/6.jpg"
  ];

  static Color getColor(String colorStr){
    switch(colorStr){
      case "Green":
        return Colors.green;
      case "Violet":
        return Color(0xFF8F00FF);
      case "Yello":
        return Colors.yellow;
      case "Blue":
        return Colors.blue;
      case "Teal":
        return Color(0xFF008080);
      case "Maroon":
        return Color(0xFF800000);
      case "Red":
        return Colors.red;
      case "Orange":
        return Colors.orange;
      case "Aquamarine":
        return Color(0xFF7FFFD4);
      case "Mauv":
        return Color(0xFFE0B0FF);
        default:
          return Colors.black;
    }
  }
}