import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/repository/repository.dart';

class ListingProvider with ChangeNotifier {
  List<Filter> _listings = [];
  int _page = 0;

  List<Filter> get listings => _listings;
  int get page => _page;

  setPage(int page){
    _page = page;
    notifyListeners();
  }

  final Repository repo = Repository();

  void addListing(Filter filter) {
    _listings.add(filter);

    notifyListeners();
  }

  Future<List<Filter>> getListings()  {
    return repo.getFilters();
  }
}
