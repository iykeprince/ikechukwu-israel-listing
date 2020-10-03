import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ikechukwu_israel/utils/custom_helpers.dart';

class DataProvider with ChangeNotifier {
  int _currentMax = 10;
  bool isFiltered = false;
  List<Csv> _csvList = [];



  int get currentMax => _currentMax;
  List<Csv> get csvList => _csvList;

  filterByYear(int year) {
    isFiltered = true;
    _csvList.where((element) =>
        element.car_model_year == year);

    notifyListeners();
  }

  filterByGender(String gender) {
    isFiltered = true;
    _csvList.where((element) => element.gender == gender).toList();

    notifyListeners();
  }

  filterByCountry(String country) {
    isFiltered = true;
    _csvList.where((element) => element.country == country).toList();
    notifyListeners();
  }

  filterByColor(String color) {
    isFiltered = true;
    _csvList.where((element) => element.car_color == color).toList();
    notifyListeners();
  }
}
