import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ikechukwu_israel/utils/custom_helpers.dart';

class CsvProvider with ChangeNotifier {
  int _currentMax = 10;
  List<Csv> _csvList = [];

  Set<String> yearSet = Set();
  Set<String> colorSet = Set();
  Set<String> countrySet = Set();
  List<String> genderSet = ['ALL', 'MALE', 'FEMALE'];


  int get currentMax => _currentMax;
  List<Csv> get csvList => _csvList;

  loadAsset() async {
    print('load Asset called');
    String myData = await rootBundle.loadString("Venten/car_ownsers_data.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    _csvList = CustomHelpers.listToMap(csvTable);
    notifyListeners();
  }


//  List<Csv> filteration(Filter selectedFilter) {
//    print('Filteration');
//    List<Csv> newCsvList = _csvList
//        .where((filter) => selectedFilter.startYear >= filter.car_model_year)
//        .toList();
//    print('new newCsvList size: ${newCsvList.length}');
//    print('new newCsvList: ${newCsvList.sublist(0, 10)}');
//    return newCsvList;
//  }

  filterByGender(String gender){
    print('Gender $gender, csv list $_csvList');
    _csvList.where((element) => element.gender == gender).toList();
  }
}
