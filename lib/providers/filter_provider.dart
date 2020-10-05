import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/repository/repository.dart';
import 'package:ikechukwu_israel/utils/custom_exception.dart';

class FilterProvider with ChangeNotifier {
  Repository repo = Repository();
  List<Filter> filters = [];
  int page = 0;
  String _errorMessage;
  String get errorMessage => _errorMessage;

  void notifyError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  setPage(int page) {
    page = page;
    notifyListeners();
  }

  // void setListing(List<Filter> filters) {
  //   filters = filters;
  //   notifyListeners();
  // }
  void setFilters(List<Filter> filters) {
    filters = filters;
    notifyListeners();
  }

  Future<List<Filter>> getFilters() async {
    try {
      return await repo.getFilters();
    } catch (e) {
      return [];
    }
  }
}
