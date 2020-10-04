import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ikechukwu_israel/utils/custom_helpers.dart';

class DataProvider with ChangeNotifier {
  int currentMax = 10;
  bool isFiltered = false;
  List<Csv> csvList = [];

  String selectedColor;

  Set<String> colorSet = Set();

  setSelectedColor(String color) {
    selectedColor = color;
    print('selectedColor: $color');
    notifyListeners();
  }

  setCsvList(List<Csv> csvList) {
    csvList = csvList;
    notifyListeners();
  }

  addCsvList(Csv csv) {
    csvList.add(csv);
    notifyListeners();
  }

  filterByYear(int year) {
    isFiltered = true;
    csvList.where((element) => element.car_model_year == year);

    notifyListeners();
  }

  filterByGender(String gender) {
    isFiltered = true;
    csvList.where((element) => element.gender == gender).toList();

    notifyListeners();
  }

  filterByCountry(String country) {
    isFiltered = true;
    csvList.where((element) => element.country == country).toList();
    notifyListeners();
  }

  filterByColor(String color) {
    isFiltered = true;
    csvList.where((element) => element.car_color == color).toList();
    notifyListeners();
  }
}
