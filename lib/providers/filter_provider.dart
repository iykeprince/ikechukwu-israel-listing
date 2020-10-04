import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/repository/repository.dart';

class FilterProvider with ChangeNotifier {
  Repository repo = Repository();
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

  
  Future<List<Filter>> getFilters() async {
    return await repo.getFilters();
  }
}
