import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/repository/repository.dart';

class FilterProvider with ChangeNotifier {
  final Repository repo = Repository();
  List<Filter> filters = [];
  int page = 0;
  
  setPage(int page) {
    page = page;
    notifyListeners();
  }

  void setListing(List<Filter> filters) {
    filters = filters;
    notifyListeners();
  }
  void setFilters(List<Filter> filters) {
    filters = filters;
  }
  Future<List<Filter>> getFilters() {
    return repo.getFilters();
  }

  setSelectedYear(selectedYear) {
    selectedYear = selectedYear;
    notifyListeners();
  }

  setSelectedGender(selectedGender) {
    selectedGender = selectedGender;
    notifyListeners();
  }

  setSelectedCountry(selectedCountry) {
    selectedCountry = selectedCountry;
    notifyListeners();
  }

  setSelectedColor(selectedColor) {
    selectedColor = selectedColor;
    notifyListeners();
  }

  setSelectedFilter(Filter selectedFilter) {
    selectedFilter = selectedFilter;
    notifyListeners();
  }
}
