import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/csv.dart';

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

  static List<Csv> listToMap(List<List<dynamic>> list) {
    List<Csv> csvList = [];
    for (int i = 1; i < list.length; i++) {
      Csv csv = Csv(
        id: list[i][0],
        first_name: list[i][1],
        last_name: list[i][2],
        email: list[i][3],
        country: list[i][4],
        car_model: list[i][5],
        car_model_year: list[i][6],
        car_color: list[i][7],
        gender: list[i][8],
        job_title: list[i][9],
        bio: list[i][10],
      );
      csvList.add(csv);
    }
    return csvList;
  }
}