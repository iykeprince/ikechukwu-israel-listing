import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/screens/csv_screen.dart';
import 'package:ikechukwu_israel/screens/home_screen.dart';

class CustomRouter {
  static Route<Widget> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case HomeScreen.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case CsvScreen.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => CsvScreen());
      default:
        return null;
    }
  }
}
