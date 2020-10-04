import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/models/year_range.dart';
import 'package:ikechukwu_israel/utils/custom_helpers.dart';

class DataProvider with ChangeNotifier {
  int currentMax = 10;
  bool isFiltered = false;
  List<Csv> _csvList = [];

  YearRange _selectedYear;
  String _selectedGender;
  String _selectedCountry;
  String _selectedColor;

  Set<YearRange> yearSet = Set();
  Set<String> countrySet = Set();
  Set<String> genderSet = Set();
  Set<String> colorSet = Set();

  YearRange get selectedYear => _selectedYear;
  setSelectedYear(YearRange selectedYear) {
    isFiltered = true;
    _selectedYear = selectedYear;
    notifyListeners();
  }

  String get selectedGender => _selectedGender;
  setSelectedGender(selectedGender) {
    isFiltered = true;
    _selectedGender = selectedGender;
    notifyListeners();
  }

  String get selectedCountry => _selectedCountry;
  setSelectedCountry(selectedCountry) {
    isFiltered = true;
    _selectedCountry = selectedCountry;
    notifyListeners();
  }

  String get selectedColor => _selectedColor;
  setSelectedColor(selectedColor) {
    isFiltered = true;
    _selectedColor = selectedColor;
    notifyListeners();
  }

  setSelectedFilter(Filter selectedFilter) {
    selectedFilter = selectedFilter;
    notifyListeners();
  }

  addCsvList(Csv csv) {
    _csvList.add(csv);
    notifyListeners();
  }

  List<Csv> get csvList {
   
    return _csvList
        .where((element) =>
            filterByYear(element) &&
            filterByGender(element) &&
            filterByCountry(element) &&
            filterByColor(element))
        .toList();
        
  }

  bool filterByYear(Csv e) {
    return selectedYear != null ?
            e.car_model_year >= selectedYear.startYear &&
            e.car_model_year <= selectedYear.endYear : true ;
  }

  bool filterByGender(Csv e) {
    return selectedGender != null ?
            e.gender.toLowerCase().compareTo(selectedGender.toLowerCase()) ==
                0 : true ;
  }

  bool filterByCountry(Csv e) {
    return selectedCountry != null ?
            e.country.toLowerCase().compareTo(selectedCountry.toLowerCase()) ==
                0 : true;
  }

  bool filterByColor(Csv e) {
    return selectedColor != null ?
            e.car_color.toLowerCase().compareTo(selectedColor.toLowerCase()) ==
                0 : true;
  }

  //for testing
  setCsvList(List<Csv> _csvList) {
    _csvList = _csvList;
    notifyListeners();
  }
}
